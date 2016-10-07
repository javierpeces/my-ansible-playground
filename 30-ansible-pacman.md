Our testbed environment has a 'desktop' and a 'victim' with dynamic IP. 
I realized and changed accordingly in /etc/ansible/hosts:
```
# this is archlnx64
[testbed]
192.168.1.88 ansible_python_interpreter=/usr/bin/python2
```
This small playbook uses the 'pacman' module for installing or updating the 'go' language interpreter
```
$ cat 30-pacman.yml 
---
- hosts: testbed
  become: true
  tasks:
  - name: update go
    pacman: name=go state=latest update_cache=yes
    register: logvar
  - debug: var=logvar
```
Use 'ansible-playbook' to run it:
```
$ ansible-playbook 30-pacman.yml -vvvv
Using /etc/ansible/ansible.cfg as config file
Loaded callback default of type stdout, v2.0
1 plays in 30-pacman.yml

PLAY ***************************************************************************
```
Unfortunately, we must deal with the IP change:
```
TASK [setup] *******************************************************************
<192.168.1.88> ESTABLISH SSH CONNECTION FOR USER: None
<192.168.1.88> SSH: EXEC ssh -C -vvv -o ControlMaster=auto -o ControlPersist=60s -o KbdInteractiveAuthentication=no -o PreferredAuthentications=gssapi-with-mic,gssapi-keyex,hostbased,publickey -o PasswordAuthentication=no -o ConnectTimeout=10 -o ControlPath=/home/sysadmin/.ansible/cp/ansible-ssh-%h-%p-%r -tt 192.168.1.88 '( umask 22 && mkdir -p "$( echo $HOME/.ansible/tmp/ansible-tmp-1475829162.32-213549365395901 )" && echo "$( echo $HOME/.ansible/tmp/ansible-tmp-1475829162.32-213549365395901 )" )'
The authenticity of host '192.168.1.88 (192.168.1.88)' can't be established.
ECDSA key fingerprint is SHA256:123456789abcdef...
Are you sure you want to continue connecting (yes/no)? yes
```
After this little manual intervention, things go on as expected:
```
<192.168.1.88> PUT /tmp/tmp35CfPS TO /home/sysadmin/.ansible/tmp/ansible-tmp-1475829162.32-213549365395901/setup
<192.168.1.88> SSH: EXEC sftp -b - -C -vvv -o ControlMaster=auto -o ControlPersist=60s -o KbdInteractiveAuthentication=no -o PreferredAuthentications=gssapi-with-mic,gssapi-keyex,hostbased,publickey -o PasswordAuthentication=no -o ConnectTimeout=10 -o ControlPath=/home/sysadmin/.ansible/cp/ansible-ssh-%h-%p-%r '[192.168.1.88]'
<192.168.1.88> ESTABLISH SSH CONNECTION FOR USER: None
<192.168.1.88> SSH: EXEC ssh -C -vvv -o ControlMaster=auto -o ControlPersist=60s -o KbdInteractiveAuthentication=no -o PreferredAuthentications=gssapi-with-mic,gssapi-keyex,hostbased,publickey -o PasswordAuthentication=no -o ConnectTimeout=10 -o ControlPath=/home/sysadmin/.ansible/cp/ansible-ssh-%h-%p-%r -tt 192.168.1.88 '/bin/sh -c '"'"'sudo -H -S -n -u root /bin/sh -c '"'"'"'"'"'"'"'"'echo BECOME-SUCCESS-ozdfnvzjxspseaeiflmebhafriduqlye; LANG=es_ES.UTF-8 LC_ALL=es_ES.UTF-8 LC_MESSAGES=es_ES.UTF-8 /usr/bin/python2 /home/sysadmin/.ansible/tmp/ansible-tmp-1475829162.32-213549365395901/setup; rm -rf "/home/sysadmin/.ansible/tmp/ansible-tmp-1475829162.32-213549365395901/" > /dev/null 2>&1'"'"'"'"'"'"'"'"''"'"''
ok: [192.168.1.88]

TASK [update go] ***************************************************************
task path: /home/sysadmin/.local/src/play/30-pacman.yml:5
<192.168.1.88> ESTABLISH SSH CONNECTION FOR USER: None
<192.168.1.88> SSH: EXEC ssh -C -vvv -o ControlMaster=auto -o ControlPersist=60s -o KbdInteractiveAuthentication=no -o PreferredAuthentications=gssapi-with-mic,gssapi-keyex,hostbased,publickey -o PasswordAuthentication=no -o ConnectTimeout=10 -o ControlPath=/home/sysadmin/.ansible/cp/ansible-ssh-%h-%p-%r -tt 192.168.1.88 '( umask 22 && mkdir -p "$( echo $HOME/.ansible/tmp/ansible-tmp-1475829167.58-20507217035459 )" && echo "$( echo $HOME/.ansible/tmp/ansible-tmp-1475829167.58-20507217035459 )" )'
<192.168.1.88> PUT /tmp/tmpu52XsL TO /home/sysadmin/.ansible/tmp/ansible-tmp-1475829167.58-20507217035459/pacman
<192.168.1.88> SSH: EXEC sftp -b - -C -vvv -o ControlMaster=auto -o ControlPersist=60s -o KbdInteractiveAuthentication=no -o PreferredAuthentications=gssapi-with-mic,gssapi-keyex,hostbased,publickey -o PasswordAuthentication=no -o ConnectTimeout=10 -o ControlPath=/home/sysadmin/.ansible/cp/ansible-ssh-%h-%p-%r '[192.168.1.88]'
<192.168.1.88> ESTABLISH SSH CONNECTION FOR USER: None
<192.168.1.88> SSH: EXEC ssh -C -vvv -o ControlMaster=auto -o ControlPersist=60s -o KbdInteractiveAuthentication=no -o PreferredAuthentications=gssapi-with-mic,gssapi-keyex,hostbased,publickey -o PasswordAuthentication=no -o ConnectTimeout=10 -o ControlPath=/home/sysadmin/.ansible/cp/ansible-ssh-%h-%p-%r -tt 192.168.1.88 '/bin/sh -c '"'"'sudo -H -S -n -u root /bin/sh -c '"'"'"'"'"'"'"'"'echo BECOME-SUCCESS-kguhnllxqcuuqmwvvtrycvxihxowlpej; LANG=es_ES.UTF-8 LC_ALL=es_ES.UTF-8 LC_MESSAGES=es_ES.UTF-8 /usr/bin/python2 -tt /home/sysadmin/.ansible/tmp/ansible-tmp-1475829167.58-20507217035459/pacman; rm -rf "/home/sysadmin/.ansible/tmp/ansible-tmp-1475829167.58-20507217035459/" > /dev/null 2>&1'"'"'"'"'"'"'"'"''"'"''
changed: [192.168.1.88] => {"changed": true, "invocation": {"module_args": {"force": false, "name": ["go"], "recurse": false, "state": "latest", "update_cache": true, "upgrade": false}, "module_name": "pacman"}, "msg": "installed 1 package(s). "}
```
See debug message:
```
TASK [debug] *******************************************************************
task path: /home/sysadmin/.local/src/play/30-pacman.yml:8
ok: [192.168.1.88] => {
    "logvar": {
        "changed": true, 
        "msg": "installed 1 package(s). "
    }
}

PLAY RECAP *********************************************************************
192.168.1.88              : ok=3    changed=1    unreachable=0    failed=0
```
Automating all this inconveniences will be the main goal...
