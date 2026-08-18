# SSH helpers.

#   ssh_noverify: connect without host key checking and without writing to
#   known_hosts. For throwaway hosts whose keys change on every rebuild.
#   Usage: ssh_noverify user@host [ssh-args...]
ssh_noverify() {
  ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "$@"
}
