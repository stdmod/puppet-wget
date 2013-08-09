#
# = Class: wget::install
#
# This class installs wget
#
class wget::install {

  if $wget::package {
    package { $wget::package:
      ensure   => $wget::managed_package_ensure,
      provider => $wget::package_provider,
      noop     => $wget::noop,
    }
  }

}
