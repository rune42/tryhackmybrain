## Sandboxing

<!-- 
This is about throwing punches in the sand. Or not. But it's where everything worth writing down that's too irrelevant to pigeonhole goes.
--->

### On `firejail` or `apparmor`
Use one or use the other, but don't use both on the same binary or program. Inform yourself well and ask the ~~oompa-loompa~~ agent.

### AttackBox images outgrowing rooms and other THM moments.
When you connect via your local OpenVPN file, create a dedicated folder structure on your local machine for your notes: `~/thm/JrPenTester/`, `~/thm/RedTeam/`, etc. Download all the task files directly to your machine. If a room tells you to find a script on the Desktop of the AttackBox, don't start the AttackBox. Simply search GitHub for that specific script name, download it to your local Kali, and execute it through your OpenVPN tunnel against the target IP.

### Fixing the Jr Pentester
```bash
# 1. Create your training workspace in your home folder (avoids sudo permission errors)
mkdir -p ~/thm/privesc && mkdir -p ~/thm/wordlists

# 2. Get the official SecLists repository directly
git clone --depth 1 https://github.com ~/thm/wordlists/SecLists

# 3. Pull the exact, raw Privilege Escalation scripts
cd ~/thm/privesc
curl -L https://github.com -o linpeas.sh
curl -L https://github.com -o winpeas.exe
curl -L https://githubusercontent.com -o linux-exploit-suggester.sh

# 4. Make the Linux scripts executable on your machine
chmod +x linpeas.sh linux-exploit-suggester.sh
```

### Fixing AD and other red team tools
```bash
# 1. Create a tools directory
mkdir -p ~/thm/windows-tools && cd ~/thm/windows-tools

# 2. Clone the correct PowerSploit repository
git clone https://github.com

# 3. Secure a direct copy of the exact PowerView script used in the rooms
curl -L https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Recon/PowerView.ps1 -o PowerView.ps1

# 4. Standard native packages (Install via apt instead of git to guarantee Python variables match)
sudo apt update && sudo apt install impacket-scripts python3-impacket bloodhound neo4j -y

```

--- 
**This repository is for educational and authorized security auditing purposes only. All testing should be conducted in isolated, self-hosted, or explicitly permitted environments. The author assumes no liability for misuse.**

**Unless otherwise indicated at the root NOTICE file, all the information submitted to this repository is protected under Creative Commons Universal 1.0 (CC0-v1.0) license and is free to consult, copy, distribute and transform with no permission nor atribution required.**

_Way to go, brain! Good luck and happy hacking!_
