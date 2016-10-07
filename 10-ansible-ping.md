Common mistake: adding a box in ansible/hosts 
and trying to run ansible stuff by its name

```
$ ansible -m ping archlnx64

 [WARNING]: provided hosts list is empty, only localhost is available
```

Now let's find and use the label; 
we never made a ssh connection to this system, so it wil fail

```
$ ansible -m ping testbed
 The authenticity of host '192.168.1.95 (192.168.1.95)' can't be established.
 ECDSA key fingerprint is SHA256:123456789abcdef123456789abcdef123456789abcd
 Are you sure you want to continue connecting (yes/no)? yes
 192.168.1.95 | UNREACHABLE! => {
     "changed": false, 
     "msg": "ERROR! SSH encountered an unknown error during the connection. 
            We recommend you re-run the command using -vvvv, 
            which will enable SSH debugging output to help diagnose the issue", 
     "unreachable": true
 }
 ```

A common ssh connection will do the trick
because it stores the host fingerprint in the known hosts file

```
$ ssh archlnx64
The authenticity of host 'archlnx64 (192.168.1.95)' can't be established.
 ECDSA key fingerprint is SHA256:123456789abcdef123456789abcdef123456789abcd
 Are you sure you want to continue connecting (yes/no)? yes
 Warning: Permanently added 'archlnx64' (ECDSA) to the list of known hosts.
 username@archlnx64's password: 
 Last login: Wed Oct  5 11:53:10 2016
```

Now you need a key pair if you don't have one already...

```
$ ssh-keygen -t rsa
Generating public/private rsa key pair.
Enter file in which to save the key (/home/username/.ssh/id_rsa): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/username/.ssh/id_rsa.
Your public key has been saved in /home/username/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:123456789abcdef123456789abcdef123456789abcd username@desktop
The key's randomart image is:
+---[RSA 2048]----+
|  .x.+X=+.       |
|   .+X=. o       |
|   o.= +. +      |
|  . X X X*       |
|     @ *Xo= .    |
|    o B.X+ o     |
|     y +.        |
|    o + ..       |
|   . =o..        |
+----[SHA256]-----+
```
Upload it to the victim...

```
$ ssh-copy-id archlnx64
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
username@archlnx64's password: *********** (type your password here)
Number of key(s) added: 1
Now try logging into the machine, with:   "ssh 'archlnx64'"
and check to make sure that only the key(s) you wanted were added.

```
... and check that you are able to ssh without typing the password.
```
$ ssh archlnx64
Last login: Thu Oct  6 14:38:28 2016 from desktop.local
```

Now you are ready to run ansible with no hassle.
```
$ ansible -m ping testbed
192.168.1.95 | FAILED! => {
    "changed": false, 
    "failed": true, 
    "module_stderr": "", 
    "module_stdout": "bash: /usr/bin/python: No such file or directory\r\n", 
    "msg": "MODULE FAILURE", 
    "parsed": false
}
```
Yes, it worked. But a python interpreter is also needed in the target box. 
Since arch uses python3 by default, we need to add an environment variable 
to the inventory file (/etc/ansible/hosts) showing the python2 location.
```
[testbed]
192.168.1.95 ansible_python_interpreter=/usr/bin/python2
```
And this is our first successful execution:
```
$ ansible -m ping testbed
192.168.1.95 | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}
```
