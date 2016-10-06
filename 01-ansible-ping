#!/bin/bash

# common mistake: adding a box in ansible/hosts 
# and trying to run ansible stuff by its name

$ ansible -m ping archlnx64
 [WARNING]: provided hosts list is empty, only localhost is available

# Now let's find and use the label 
# We never made a ssh connection to this system, so it wil fail

sysadmin@linordix:~$ ansible -m ping testbed
 The authenticity of host \'192.168.50.95 (192.168.50.95)\' can\'t be established.
 ECDSA key fingerprint is SHA256:123456789abcdef123456789abcdef123456789abcd
 Are you sure you want to continue connecting (yes/no)? yes
 192.168.50.95 | UNREACHABLE! => {
     \"changed\": false, 
     \"msg\": \"ERROR! SSH encountered an unknown error during the connection. 
             We recommend you re-run the command using -vvvv, 
             which will enable SSH debugging output to help diagnose the issue\", 
     \"unreachable\": true
 }

# A common ssh connection will do the trick
# because it stores the host fingerprint in the known hosts file

$ ssh archlnx64
The authenticity of host \'archlnx64 (192.168.50.95)\' can\'t be established.
 ECDSA key fingerprint is SHA256:123456789abcdef123456789abcdef123456789abcd
 Are you sure you want to continue connecting (yes/no)? yes
 Warning: Permanently added \'archlnx64\' (ECDSA) to the list of known hosts.
 username@archlnx64\'s password: 
 Last login: Wed Oct  5 11:53:10 2016

# Good...
