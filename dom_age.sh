#!/bin/bash

# Description:
# This script processes a list of domains from a provided file, retrieves their
# creation dates using the whois command, and groups the domains by their creation
# dates. The script provides real-time feedback on the progress, displaying which
# domain is being checked and how many domains remain. At the end, it asks the
# user if they want to save the result to a file with a suffix "new". 
# The default answer is yes (y for yes and n for no).
#
# Usage:
# ./dom_age.sh <file_with_domains>
#
# Parameters:
# <file_with_domains> - A file containing a list of domain names, one per line.
#
# Example:
# ./dom_age.sh domains.txt

# Check if the file with domains is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <file_with_domains>"
    exit 1
fi

# File with the list of domains
file=$1

# Temporary files to store domains and their creation dates and progress
temp_file=$(mktemp)
progress_file=$(mktemp)

# Get the total number of domains
total_domains=$(wc -l < "$file")
current_domain=0

# Function to get the creation date of a domain
get_creation_date() {
    domain=$1
    creation_date=$(whois "$domain" | grep -i 'Creation Date' | head -1 | awk '{print $NF}' | cut -d'T' -f1)
    if [ -z "$creation_date" ]; then
        creation_date="0000-00-00"
    fi
    echo "$creation_date $domain"
}

# Iterate over each domain in the file
while read -r domain; do
    current_domain=$((current_domain + 1))
    echo -ne "Processing domain $current_domain of $total_domains: $domain\r" | tee -a "$progress_file"
    get_creation_date "$domain" >> "$temp_file"
done < "$file"

# Clear the real-time feedback
cat /dev/null > "$progress_file"

# Sort the domains by creation date and group them
result=$(sort "$temp_file" | awk '{print $1, $2}' | uniq | while read -r date domain; do
    echo "$date: $domain"
done)

# Print the result
echo "$result"

# Ask the user if they want to save the result to a file
read -p "Do you want to save the result to a file? (y/n) [y]: " save_result
save_result=${save_result:-y}

if [[ "$save_result" == "y" ]]; then
    output_file="${file}_new"
    echo "$result" > "$output_file"
    echo "Result saved to $output_file"
fi

# Clean up temporary files
rm "$temp_file" "$progress_file"

echo "Done processing $total_domains domains."
