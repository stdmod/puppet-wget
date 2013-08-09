#
# Testing configuration file provisioning via template
# Auditing enabled
#
class { 'wget':
  template => 'wget/tests/test.conf',
  audit    => 'all',
}
