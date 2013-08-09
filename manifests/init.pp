#
# = Class: wget
#
# This class installs and manages wget
#
#
# == Parameters
#
# Refer to the official documentation for standard parameters usage.
# Look at the code for the list of supported parametes and their defaults.
#
class wget (

  $ensure              = 'present',
  $version             = undef,
  $audit               = undef,
  $noop                = undef,

  $package             = $wget::params::package,
  $package_provider    = undef,

  $service             = $wget::params::service,
  $service_ensure      = 'running',
  $service_enable      = true,
  $service_subscribe   = $wget::params::service_subscribe,
  $service_provider    = undef,

  $file                = $wget::params::file,
  $file_owner          = $wget::params::file_owner,
  $file_group          = $wget::params::file_group,
  $file_mode           = $wget::params::file_mode,
  $file_replace        = $wget::params::file_replace,
  $file_source         = undef,
  $file_template       = undef,
  $file_content        = undef,
  $file_options_hash   = undef,

  $dir                 = $wget::params::dir,
  $dir_source          = undef,
  $dir_purge           = false,
  $dir_recurse         = true,

  $dependency_class    = undef,
  $monitor_class       = 'wget::monitor',
  $firewall_class      = 'wget::firewall',
  $my_class            = undef,

  $monitor             = false,
  $monitor_host        = $::ipaddress,
  $monitor_port        = 22,
  $monitor_protocol    = tcp,
  $monitor_tool        = '',

  $firewall            = false,
  $firewall_src        = '0/0',
  $firewall_dst        = '0/0',
  $firewall_port       = 22,
  $firewall_protocol   = tcp

  ) inherits wget::params {


  # Input parameters validation
  validate_re($ensure, ['present','absent'], 'Valid values are: present, absent. WARNING: If set to absent all the resources managed by the module are removed.')
  validate_bool($service_enable)
  validate_bool($dir_recurse)
  validate_bool($dir_purge)
  if $file_options_hash { validate_hash($file_options_hash) }

  # Calculation of variables used in the module
  if $file_content {
    $managed_file_content = $file_content
  } else {
    if $file_template {
      $managed_file_content = template($file_template)
    } else {
      $managed_file_content = undef
    }
  }

  if $version {
    $managed_package_ensure = $version
  } else {
    $managed_package_ensure = $ensure
  }

  if $ensure == 'absent' {
    $managed_service_enable = undef
    $managed_service_ensure = stopped
    $dir_ensure = absent
    $file_ensure = absent
  } else {
    $managed_service_enable = $service_enable
    $managed_service_ensure = $service_ensure
    $dir_ensure = directory
    $file_ensure = present
  }


  # Resources Managed
  class { 'wget::install':
  }

  class { 'wget::service':
    require => Class['wget::install'],
  }

  class { 'wget::config':
    require => Class['wget::install'],
  }


  # Extra classes
  if $wget::dependency_class {
    include $wget::dependency_class
  }

  if $wget::monitor and $wget::monitor_class {
    include $wget::monitor_class
  }

  if $wget::firewall and $wget::firewall_class {
    include $wget::firewall_class
  }

  if $wget::my_class {
    include $wget::my_class
  }

}
