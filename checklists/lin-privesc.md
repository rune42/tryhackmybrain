# Checklist: Linux Privilege Escalation

**Objective:** Systematically enumerate a Linux target after gaining an initial low-privilege shell to identify paths to `root`.

**Last Updated:** 2026-08-07

---

## Phase 0: Shell Stabilization
Before executing any heavy enumeration tools or scripts, ensure the shell is interactive and stable to prevent accidental dropouts.

- [ ] **Spawn a TTY Shell:** Upgrade the basic reverse shell using Python or script techniques.
  * *Reference:* See syntax options in [`../cheat-sheets/shells/tty-upgrades.md`](../cheat-sheets/shells/tty-upgrades.md).
- [ ] **Set Environment Variables:** Export clean term settings and fix terminal window geometry (`stty rows/cols`).

---

## Phase 1: Automated Initial Triaging
Run lightweight automation scripts to gather a baseline profile of the operating system configuration.

- [ ] **Execute LinPEAS:** Pipe the output to a log file or execute in-memory to look for quick wins (vector color-coding).
  * *Reference:* Setup and usage flags in [`../cheat-sheets/tools/linpeas.md`](../cheat-sheets/tools/linpeas.md).
- [ ] **Fallback to Alternative Enumeration Scripts:** If Python or Bash constraints block LinPEAS, deploy `LinEnum` or `linux-exploit-suggester`.

---

## Phase 2: Manual Enumeration & Verification
*Always manually verify automated findings to avoid false positives or noisy exploits.*

### 1. User & Environment Profiling
- [ ] **Check Current Identity & Privileges:** Run `id`, `whoami`, and check environmental variables for hidden secrets.
- [ ] **Review Available Sudo Privileges:** Run `sudo -l` to check for binaries that can be executed as root without a password.
  * *Action:* Cross-reference any discovered binaries with [GTFOBins](https://github.io).
- [ ] **Examine User Home Directories:** Look for readable `.bash_history`, `.ssh/` folders, or plain-text config files.

### 2. System & Kernel Level Check
- [ ] **Determine OS Architecture & Kernel Version:** Run `uname -a` and check `/etc/issue`.
- [ ] **Identify Running Services:** Look for internal-only ports or services running as root using `netstat` or `ss`.
<!---
  * *Reference:* See [`../cheat-sheets/linux/networking-commands.md`](../cheat-sheets/linux/networking-commands.md).
-->
### 3. File System & Permissions
- [ ] **Search for SUID/SGID Binaries:** Hunt for files with anomalous execution permissions.
  * *Reference:* Custom `find` commands located in [`../cheat-sheets/linux/file-searching.md`](../cheat-sheets/linux/file-searching.md).
- [ ] **Inspect Writable Directories/Files:** Check if critical files like `/etc/passwd` or cron job directories are world-writable.

---

## Phase 3: Exploitation & Post-Exploitation
- [ ] **Compile/Transfer Exploit Safely:** Compile payloads locally when possible to avoid leaving compiler artifacts on the target system.
- [ ] **Verify Root Persistence:** Once root is achieved, extract the flag, document the path, and establish clean persistence if required by the challenge scope.

---

## Deviation Notes (Box-Specific Observations)
*WIP*

---
**Unless otherwise indicated at the root NOTICE file, all the information submitted to this repo is protected under Creative Commons Universal 1.0 (CC0-v1.0) license and is free to consult, copy, distribute and transform with no permission nor atribution required.**

_Way to go, brain! Good luck and happy hacking!_
