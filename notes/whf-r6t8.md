# Web Hacking Fundamentals
## Upload Vulnerabilities
### Task 8 - Bypassing file extension (annex)

Overall, this task introduced me to the daunting world of obfuscated script files. I spent a good two hours battling this very room to no avail, but here is an in-line Python decryptor that provided me with the first legible glossary.

```
python3 -c 'import re,ast; s=open("script.js","r",errors="ignore").read(); line=re.search(r"const\s+_0x271c\s*=\s*\[[^\n]*\]", s).group(0); arr=ast.literal_eval(line.split("=",1)[1].strip().rstrip(";")); [print(f"0x{i:x}\t{v}") for i,v in enumerate(arr)]' | tee /tmp/strings_dump.txt
```

#### So what does it do?
This one-liner extracts the obfuscation “string table” (`const _0x271c = [...]`) from `script.js` and prints every entry with its hex index (`0x0`, `0x1`, ...). Those indices are what calls like `_0x1d1e('0x1a')` resolve to, so this gives you a quick glossary of real strings (DOM selectors, command keywords, error messages) without manually decoding each reference.

* Uses `re.search()` to grab the `const _0x271c = [...]` line.
* Uses `ast.literal_eval()` (safer than `eval`) to parse the JavaScript-style string array into a Python list.
* Prints `0x<index>\t<value>` and saves output to `/tmp/strings_dump.txt` via `tee`.
