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

  $package             = $wget::params::package,

  $file                = $wget::params::file,
  $file_source         = undef,
  $file_template       = undef,
  $file_content        = undef,
  $file_options_hash   = undef,

  ) inherits wget::params {


  # Input parameters validation
  validate_re($ensure, ['present','absent'], 'Valid values are: present, absent. WARNING: If set to absent all the resources managed by the module are removed.')
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
    $file_ensure = absent
  } else {
    $file_ensure = present
  }

  if $wget::package {
    package { $wget::package:
      ensure   => $wget::managed_package_ensure,
    }
  }

  if $wget::file {
    file { 'wget.conf':
      ensure  => $wget::file_ensure,
      path    => $wget::file,
      mode    => $wget::file_mode,
      owner   => $wget::file_owner,
      group   => $wget::file_group,
      source  => $wget::file_source,
      content => $wget::managed_file_content,
    }
  }

}
