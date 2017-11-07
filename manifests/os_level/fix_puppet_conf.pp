#
# Patch puppet.conf with additional rules for splay and splaylimit
# this will add a random delay up to the runtime of puppet 
# and should help reducing the load to foreman due to not having 
# to process large amount of hosts at once.
#
# Author: Hugo van Duijn
#
class patches::os_level::fix_puppet_conf(
  $config_path = '/etc/puppet/puppet.conf',  # puppet3 default
)
{
  file_line { 'add splay':
    ensure             => present,
    path               => $config_path,
    after              => '\[agent\]',
    line               => 'splay           = true',
    notify             => Exec['restart puppet'],
  }

  exec {'restart puppet':
    refreshonly        => true,
    command            => '/usr/sbin/service puppet restart'
  }
}
