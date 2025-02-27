## Domain Creation Date Sorter

This repository contains a bash script that processes a list of domains, retrieves their creation dates using the `whois` command, and groups the domains by their creation dates. 

The script provides real-time feedback on the progress, displaying which domain is being checked and how many domains remain. 

At the end, it asks the user if they want to save the result to a file with a suffix '**new**'. 

The default answer is yes (`y` for **yes** and `n` for **no**).

### Usage

To use the script, follow these steps:

1. Ensure you have the `whois` command installed on your system.
2. Save the list of domains to a file (one domain per line).
3. Run the script with the file of domains as an argument.

### Parameters

- `<file_with_domains>`: A file containing a list of domain names, one per line.

#### Example

- `./dom_age.sh domains.txt`

### Output

The script will print the domains grouped by their creation dates in a readable format. 

If the creation date is not found, it will mark it as "`0000-00-00`".

#### Example Output

```
Processing domain 1 of 12: google.com
Processing domain 2 of 12: facebook.com
Processing domain 3 of 12: amazon.com
Processing domain 4 of 12: twitter.com
Processing domain 5 of 12: wikipedia.org
Processing domain 6 of 12: youtube.com
Processing domain 7 of 12: linkedin.com
Processing domain 8 of 12: instagram.com
Processing domain 9 of 12: reddit.com
Processing domain 10 of 12: netflix.com
Processing domain 11 of 12: microsoft.com
Processing domain 12 of 12: apple.com

1987-02-19: apple.com
1991-05-02: microsoft.com
1994-11-01: amazon.com
1997-03-29: facebook.com
1997-09-15: google.com
1997-11-10: netflix.com
2000-01-21: twitter.com
2001-01-13: wikipedia.org
2002-05-05: linkedin.com
2010-10-06: instagram.com
2005-02-15: youtube.com
2005-06-23: reddit.com

Do you want to save the result to a file? (y/n) [y]: 
Result saved to domains_new
Done processing 12 domains.
```

## License

This project is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported.

See [LICENSE](https://creativecommons.org/licenses/by-nc-sa/3.0/) for details. 
