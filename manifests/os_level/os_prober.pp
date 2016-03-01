#
# Patch os_prober if file exists
#
class patches::os_level::os_prober(
  $ensure           = present,
){

# only patch if file exists. 
  if file_exists ("/etc/grub.d/30_os-prober") == 0 {
    file_line {'os_prober_disable':
      ensure            => $ensure,
      path              => '/etc/grub.d/30_os-prober',
      line              => 'GRUB_DISABLE_OS_PROBER=true',
      match             => 'GRUB_DISABLE_OS_PROBER=',
      match_for_absence => true,
      after             => 'quick_boot="1"',
    }
  }
}