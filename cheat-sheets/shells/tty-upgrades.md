## TTY Shell Upgrades

### Standard Bash
A simple shell upgrade that prevents escape commands from breaking the reverse handshake by accident.
```
/usr/bin/script -qc /bin/bash /dev/null
```

### Python PTY
Bypasses some root privileges, but otherwise similar to the standard Bash upgrade. Make sure to run `python -V` and/or `python3 -V` as a sanity check.
```
python -c 'import pty; pty.spawn("/bin/bash")'
/usr/bin/python -c 'import pty; pty.spawn("/bin/bash")'

# Python 3
python3 -c 'import pty; pty.spawn("/bin/bash")'
/usr/bin/python3 -c 'import pty; pty.spawn("/bin/bash")'
```

### Spawn TTY full
A solid shell upgrade that functionally acts as a SSH session. Recommend to try one of the above first.
```
# Spawn Python shell
python -c 'import pty; pty.spawn("/bin/bash")'

# Background the shell
Ctrl + Z

# Get current Rows and Columns
stty -a | head -n1 | cut -d ';' -f 2-3 | cut -b2- | sed 's/; /\n/'

# Bring shell back to the foreground
stty raw -echo; fg

# Set size for the remote shell 
# (where ROWS and COLS are the values from the 3rd command)
stty rows ROWS cols COLS

# Add some colours
export TERM=xterm-256color

# Reload bash to apply the TERM variable
exec /bin/bash
```

### Spawn TTY lite
A more minimal, less computationally heavy variation of the full Spawn TTY upgrade.
```
# Spawn Python shell
python -c 'import pty;pty.spawn("/bin/bash")'

# Give terminal functions
export TERM=xterm

# Background the shell
Ctrl + Z

# Bring shell back to the foreground 
stty raw -echo; fg
```
