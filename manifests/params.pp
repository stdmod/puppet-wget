# Class: wget::params
#
# Defines all the variables used in the module.
#
class wget::params {

  $package = 'wget'

  $file = $::osfamily ? {
    default => '/etc/wgetrc',
  }

  $file_mode = '0644'

  $file_owner = $::osfamily ? {
    default => 'root',
  }

  $file_group = $::osfamily ? {
    default => 'root',
  }

}
