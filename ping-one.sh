#
# host0 is a valid hostname in dns
# user is in wheel, so it's a passless sudoer
#

$ ansible -m ping -b -u user -i 'host0,' all
host0 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}

#
# ads01 is valid in dns, but user's access is not enabled (lacks ssh-copy-id)
#

$ ansible -m ping -b -u user -i 'ads01,host2' all
ads01 | UNREACHABLE! => {
    "changed": false,
    "msg": "Failed to connect to the host via ssh: user@ads01: Permission denied (publickey,...",
    "unreachable": true
}
host2 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}

# eof
