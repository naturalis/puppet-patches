#
# Patch puppet.conf with additional rules for splay and splaylimit
# this will add a random delay up to 5 minutes to a puppetrun 
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
  }

  file_line { 'add splaylimit':
    ensure             => present,
    path               => $config_path,
    after              => '\[agent\]',
    line               => 'splaylimit      = 5m',
    require            => File_line['add splay'],
    notify             => Exec['restart puppet'],
  }

  exec {'restart puppet':
    refreshonly        => true,
    command            => '/usr/sbin/service puppet restart'
  }
}
