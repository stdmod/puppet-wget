#
# Testing configuration file provisioning via source
# Auditing enabled
#
class { 'wget':
  source => 'puppet:///modules/wget/tests/test.conf',
  audit  => 'all',
}
