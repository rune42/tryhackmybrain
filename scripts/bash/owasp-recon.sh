#!/bin/bash
# OWASP Top 10 Recon & Test Script
# Usage: ./owasp-recon.sh http://example.com

TARGET=$1
WORDLIST="/usr/share/wordlists/dirb/common.txt"

echo "[+] Scanning OWASP targets for: $TARGET"

# A05: Injection - Test basic Cross-Site Scripting (XSS) via GET parameters
echo "[+] Checking for XSS candidates in URL parameters..."
curl -s -G --data-urlencode "q=<script>alert(1)</script>" "$TARGET" | grep -q "<script>alert(1)</script>"
if [ $? -eq 0 ]; then
    echo "[!] Potential XSS found in parameter!"
fi

# A02: Security Misconfiguration & Broken Access Control - Header check
echo "[+] Checking Security Headers..."
curl -s -I "$TARGET" | grep -E "Server|X-Powered-By|X-Frame-Options|Content-Security-Policy"

# A04: Cryptographic Failures - Check for SSL/TLS
echo "[+] Checking if using HTTPS..."
echo | openssl s_client -connect "${TARGET#*://}":443 2>/dev/null | grep -i "Protocol"

# A02: Security Misconfiguration - Directory Brute Force
echo "[+] Brute forcing directories for exposed files..."
if command -v ffuf &> /dev/null; then
    ffuf -w "$WORDLIST" -u "$TARGET/FUZZ" -mc 200,301,403
else
    echo "[-] ffuf is not installed. Skipping brute force."
fi

echo "[*] Script complete. Refer to the OWASP Top 10 checklist for manual testing."
