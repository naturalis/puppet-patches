#
#
#    unless  => ["/usr/bin/apt-get check"] changed so install will always run when key is not available
#
class patches::os_level::fix_puppet_repo(
){

  exec {"fix puppet apt-repo" :
    command => "/usr/bin/gpg --keyserver pgp.mit.edu --recv-key 7F438280EF8D349F && gpg -a --export EF8D349F | apt-key add - && sudo dpkg --configure -a && apt-get update",
    unless  => ["/usr/bin/apt-key list | grep -c EF8D349F"]
  }
}
