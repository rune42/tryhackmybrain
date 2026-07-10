# John the Ripper Cheat Sheet

## Syntax Summary

John the Ripper automatically detects hashes, but you can force specific formats or modes using flags.

### Basic Commands
* **Auto-detect & Crack:** `john --wordlist=wordlist.txt [hash_file]`
* **Force a Format:** `john --format=[format_name] --wordlist=wordlist.txt [hash_file]`
* **Show Cracked Passwords:** `john --show [hash_file]`

### Format Information
* **List Supported Formats:** `john --list=formats`
* **View Format Details:** `john --list=format-all-details`

### Hash Extraction Helpers
Extract target hashes from files before cracking:
* **SSH Keys:** `ssh2john.py id_rsa > ssh_hash.txt`
* **ZIP Archives:** `zip2john archive.zip > zip_hash.txt`
* **RAR Archives:** `rar2john archive.rar > rar_hash.txt`

---

## Hash Formats List

Use these names exactly as written for the `--format=[format_name]` flag.

### Standard Operating System Hashes
* **Traditional DES:** `descrypt`
* **BSDI Extended DES:** `bsdi`
* **MD5 Crypt:** `md5crypt`
* **Bcrypt / OpenBSD Blowfish:** `bcrypt`
* **SHA-256 Crypt:** `sha256crypt`
* **SHA-512 Crypt:** `sha512crypt`
* **Generic Crypt:** `crypt`

### Windows & Network Hashes
* **LM:** `LM`
* **NTLM:** `nt`
* **WPA/WPA2 (PMKID):** `wpapsk`

### Archives & Documents
* **ZIP:** `zip`
* **RAR:** `rar`
* **PDF:** `pdf`
* **MS Office:** `office`

### Web Applications & CMS
* **WordPress / phpBB (MD5):** `phpass`
* **Apache (APR1 / MD5):** `apr1`
* **vBulletin:** `vbulletin`
* **Joomla:** `joomla`
---
**Unless otherwise indicated at the root NOTICE file, all the information submitted to this repo is protected under Creative Commons Universal 1.0 (CC0-v1.0) license and is free to consult, copy, distribute and transform with no permission nor atribution required.**

_Way to go, brain! Good luck and happy hacking!_
