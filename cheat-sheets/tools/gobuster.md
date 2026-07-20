## Gobuster
This tool is used for brute force enumeration of visible web endpoints.
### Basic syntax
```bash
gobuster [mode] -u [URL] -w [wordlist] [flags]
```

### Folder and file scanning (`dir`)
- Scan for hidden directories and web files
```bash
gobuster dir -u https://example.com -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -t 20 -x php,html
```
- Scan for files with certain extensions
```bash
gobuster dir -u https://example.com -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -x php,txt,bak
```
- Hide HTML 404 codes
```bash
gobuster dir -u https://example.com -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -b 404
```
### Domain and subdomain probing (`dns`)
```bash
gobuster dns -d example.com -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -i
```
---
**This repository is for educational and authorized security auditing purposes only. All testing should be conducted in isolated, self-hosted, or explicitly permitted environments. The author assumes no liability for misuse.**
**Unless otherwise indicated at the root NOTICE file, all the information submitted to this repository is protected under Creative Commons Universal 1.0 (CC0-v1.0) license and is free to consult, copy, distribute and transform with no permission nor atribution required.**

_Way to go, brain! Good luck and happy hacking!_
