# my-ansible-playground

Let's do the ansible dance...

Got a VM to act as a guinea pig. Address is 192.168.50.95/24 and hostname is archlnx64.
My desktop's /etc/hosts contains one line like this:
```
192.168.50.95   archlnx64
```
This is my desktop's /etc/ansible/hosts relevant part:
```
[testbed]
# this is archlnx64
192.168.50.95
```
The first thing to be done is, of course, ensuring access from the desktop to the victim:
```
$ ping 192.168.50.95
PING 192.168.50.95 (192.168.50.95) 56(84) bytes of data.
64 bytes from 192.168.50.95: icmp_seq=1 ttl=64 time=0.174 ms
64 bytes from 192.168.50.95: icmp_seq=2 ttl=64 time=0.183 ms
```
This is good. But ansible needs sshd running in the victim...
```
$ **systemctl status sshd**
```
