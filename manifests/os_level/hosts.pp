#
# add custom entries to hosts file
# 
#
# Author: Hugo van Duijn
#
# ensure: present of absent
#
class patches::os_level::hosts(
  $hosts_hash       = { 'testhostname' => { 'ip'        => '10.1.1.1',
                                            'ensure'    => 'absent',
                                            'comment'   => 'hosts entry by patch',
                                            'alias'     => ['hostname.full','hostname.local']
                                          }
                      }
){

# make updateHosts function
  define patches::os_level::hosts::updateHosts (
    $ip,
    $ensure       = present,
    $comment      = undef,
    $alias        = undef,
  )
  {
    host { $title:
      name         => $title,
      ensure       => $ensure,
      comment      => $comment,
      host_aliases => $alias,
      ip           => $ip
    }
  }

# create symlinks for each plugin in plugin_array
   create_resources('patches::os_level::hosts::updateHosts', $hosts_hash)

}
