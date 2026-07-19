# Tips & tricks for Ansible

A curated collection of essential commands, performance optimizations, and advanced patterns for modern infrastructure automation.

---

## Quick Ad-Hoc Commands
Run fast, one-off tasks across your infrastructure without writing full playbooks:

```bash
# Verify connectivity with all inventory hosts
ansible all -m ping

# Check server uptime across the infrastructure
ansible all -m shell -a "uptime"

# Install Nginx ensuring root privileges (prompting for sudo password)
ansible webservers -m apt -a "name=nginx state=present" -b -K

# Securely reboot a specific group of database servers
ansible dbservers -m reboot -b
```

---

## Performance Optimizations
Drastically reduce playbook execution times on large environments using these configurations:

### 1. Disable Unnecessary Fact Gathering
If your tasks do not require system variables (like OS version or IP addresses), skip this heavy step.
```yaml
- hosts: all
  gather_facts: false
```

### 2. Enable SSH Pipelining
Reduces the number of SSH connections required to execute a module by running it directly in memory. Configure this in your `ansible.cfg`:
```ini
[ssh_connection]
pipelining = true
```

### 3. Use the Free Execution Strategy
By default, Ansible waits for all hosts to finish a task before moving to the next. The `free` strategy allows each host to run through the playbook as fast as it can independently.
```yaml
- hosts: all
  strategy: free
```

---

## Secret Management with Ansible Vault
Keep sensitive data like API keys, passwords, and certificates encrypted inside your repository:

```bash
# Create a new encrypted variables file from scratch
ansible-vault create secrets.yml

# Encrypt an existing plain-text file
ansible-vault encrypt credentials.yml

# Edit an encrypted file on the fly without manual decryption
ansible-vault edit secrets.yml

# Run a playbook that requires vault-encrypted variables
ansible-playbook playbook.yml --ask-vault-pass
```

---

## Development & Troubleshooting Flag Guide
Speed up your testing cycles and root out errors with these CLI flags:

* **`--check`**: Dry-run mode. Simulates execution to show what would change without modifying targets.
* **`--syntax-check`**: Validates YAML formatting and basic structure before deployment.
* **`-vvv`**: Maximizes verbosity. Essential for troubleshooting SSH handshake issues or raw module payloads.
* **`--start-at-task="Task Name"`**: Skips directly to a specific task to save time during iterative development.

---

## Advanced Playbook Patterns

### Secure Configuration Validation
Never break a live configuration file again. Use the `validate` parameter to run checks before committing the file to its destination:
```yaml
- name: Update sudoers file safely
  copy:
    src: files/sudoers
    dest: /etc/sudoers
    validate: /usr/sbin/visudo -csf %s
```

### Graceful Error Handling (Block & Rescue)
Build resilient workflows by defining fallback tasks if a primary action fails:
```yaml
- block:
    - name: Try executing the primary application setup
      command: /opt/bin/setup.sh
  rescue:
    - name: Fallback logic executed only if setup fails
      debug:
        msg: "Primary configuration failed. Initiating automatic rollback..."
```

---

## Easter Egg: The Ansible Cow 🐄
Did you know Ansible natively loves cows? If you have the `cowsay` utility installed on your control node, Ansible automatically wraps all terminal task headers inside a friendly ASCII cow speech bubble!

### Customizing or Disabling the Cow
If you want to control this behavior via your `ansible.cfg` file, use the following options under the `[defaults]` section:

* **To disable it entirely** (if the ASCII art breaks your logs or CI/CD pipelines):
  ```ini
  [defaults]
  nocows = 1
  ```
* **To change the animal** (if you have different `.cow` files installed on your system):
  ```ini
  [defaults]
  cow_selection = tux
  ```
---
**Unless otherwise indicated at the root NOTICE file, all the information submitted to this repo is protected under Creative Commons Universal 1.0 (CC0-v1.0) license and is free to consult, copy, distribute and transform with no permission nor atribution required.**

_Way to go, brain! Good luck and happy hacking!_
