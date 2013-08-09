# Puppet module: wget

This is a Puppet module for wget.
It manages its installation and configuration.

The module is based on stdmod naming standars.
Refer to http://github.com/stdmod/

Released under the terms of Apache 2 License.


## USAGE - Basic management

* Install wget with default settings (package installed, service started, default configuration files)

        class { 'wget': }

* Remove wget package and purge all the managed files

        class { 'wget':
          ensure => absent,
        }

* Install a specific version of wget package

        class { 'wget':
          version => '1.0.1',
        }

* Install the latest version of wget package

        class { 'wget':
          version => 'latest',
        }


## USAGE - Overrides and Customizations
* Use custom source for main configuration file 

        class { 'wget':
          file_source => [ "puppet:///modules/example42/wget/wget.conf-${hostname}" ,
                           "puppet:///modules/example42/wget/wget.conf" ], 
        }


* Use custom template for main config file. Note that template and source arguments are alternative.

        class { 'wget':
          file_template => 'example42/wget/wget.conf.erb',
        }

* Use a custom template and provide an hash of custom configurations that you can use inside the template

        class { 'wget':
          filetemplate       => 'example42/wget/wget.conf.erb',
          file_options_hash  => {
            opt  => 'value',
            opt2 => 'value2',
          },
        }



## TESTING
[![Build Status](https://travis-ci.org/stdmod/puppet-wget.png?branch=master)](https://travis-ci.org/stdmod/puppet-wget)
