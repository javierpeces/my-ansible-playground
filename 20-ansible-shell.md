One step beyond: Using the 'shell' module instead of 'ping'. 

```
$ ansible -m shell testbed -a 'uname -a'
192.168.50.95 | SUCCESS | rc=0 >>
Linux archlnx64 4.7.6-1-ARCH #1 SMP PREEMPT Fri Sep 30 19:28:42 CEST 2016 x86_64 GNU/Linux

```
We are running stuff with our regular username. Using '-s' adds sudo functionality.

```
$ ansible -m shell testbed -a 'whoami'
192.168.50.95 | SUCCESS | rc=0 >>
username

$ ansible -s -m shell testbed -a 'whoami'
192.168.50.95 | SUCCESS | rc=0 >>
root
```
Arbitrary commands are available:
```
sysadmin@linordix:~$ ansible -m shell testbed -a 'uptime'
192.168.50.95 | SUCCESS | rc=0 >>
 15:48:29 up  2:04,  2 users,  load average: 0,00, 0,00, 0,00

sysadmin@linordix:~$ ansible -m shell testbed -a 'free -m'
192.168.50.95 | SUCCESS | rc=0 >>
              total        used        free      shared  buff/cache   available
Mem:           2001         217        1536           2         247        1630
Swap:          2407           0        2407
```
