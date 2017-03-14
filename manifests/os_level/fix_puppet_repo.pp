#
#
#
class patches::os_level::fix_puppet_repo(
){

  exec {"fix puppet apt-repo" :
    command => "/bin/bin/gpg --keyserver pgp.mit.edu --recv-key 7F438280EF8D349F && gpg -a --export EF8D349F | apt-key add - && sudo dpkg --configure -a && apt-get update",
    unless  => "/usr/bin/apt-get check"
  }
}
