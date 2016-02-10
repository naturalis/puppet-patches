#
#
#
class patches::os_level::os_prober(
  $ensure = present,
){
  file_line {'os_prober_disable':
    ensure            => $ensure,
    path              => '/etc/grub.d/30_os-prober',
    line              => 'GRUB_DISABLE_OS_PROBER=true',
    match             => 'GRUB_DISABLE_OS_PROBER=',
    match_for_absence => true,
    after             => 'quick_boot="1"',
  }
}
