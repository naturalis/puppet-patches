#
# Patch os_prober if file exists
# use with care and only when needed due to lots of stuck systems 
# from os-prober problems, fix includes killing a lot of processes
#
# Author: Hugo van Duijn
#
class patches::os_level::fix_dpkg(
){

  file { '/opt/fixdpkg.sh':
    ensure    => 'present',
    content   =>  template('patches/fixdpkg.sh.erb'),
    mode      => '0700',
  }

  exec { "fix dpkg when stuck in os_prober":
    command         => "/opt/fixdpkg.sh",
    path            =>  [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
    onlyif          => 'lsof | grep -c 30_os-prober',
    require         => File['/opt/fixdpkg.sh']
  }

  
}
