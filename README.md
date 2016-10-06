# my-ansible-playground

Let's do the ansible dance...

Got a VM to act as a guinea pig. Address is 192.168.50.95/24 and hostname is archlnx64.
My desktop's /etc/hosts contains one line like this:
```
192.168.50.95   archlnx64
```
This is my desktop's /etc/ansible/hosts relevant part:
```
# this is archlnx64
[testbed]
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
$ systemctl status sshd
· sshd.service - OpenSSH daemon
   Loaded: loaded (/usr/lib/systemd/system/sshd.service; disabled; vendor preset: disabled)
   Active: inactive (dead)
```
And this is bad. We need to start ssh access in the remote machine. 
Don't forget to enable it or it won't start in further reboots.
```
$ sudo systemctl start sshd
$ sudo systemctl enable sshd

```
