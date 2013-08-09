# Puppet module: wget

This is a Puppet module for wget.
It manages its installation, configuration and service.

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

* Enable wget service. This is default.

        class { 'wget':
          service_ensure => 'running',
        }

* Enable wget service at boot. This is default.

        class { 'wget':
          service_status => 'enabled',
        }


* Do not automatically restart services when configuration files change (Default: Class['wget::config']).

        class { 'wget':
          service_subscribe => false,
        }

* Enable auditing (on all the arguments)  without making changes on existing wget configuration *files*

        class { 'wget':
          audit => 'all',
        }

* Module dry-run: Do not make any change on *all* the resources provided by the module

        class { 'wget':
          noop => true,
        }


## USAGE - Overrides and Customizations
* Use custom source for main configuration file 

        class { 'wget':
          file_source => [ "puppet:///modules/example42/wget/wget.conf-${hostname}" ,
                           "puppet:///modules/example42/wget/wget.conf" ], 
        }


* Use custom source directory for the whole configuration dir.

        class { 'wget':
          dir_source  => 'puppet:///modules/example42/wget/conf/',
        }

* Use custom source directory for the whole configuration dir purging all the local files that are not on the dir.
  Note: This option can be used to be sure that the content of a directory is exactly the same you expect, but it is desctructive and may remove files.

        class { 'wget':
          dir_source => 'puppet:///modules/example42/wget/conf/',
          dir_purge  => true, # Default: false.
        }

* Use custom source directory for the whole configuration dir and define recursing policy.

        class { 'wget':
          dir_source    => 'puppet:///modules/example42/wget/conf/',
          dir_recursion => false, # Default: true.
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


* Specify the name of a custom class to include that provides the dependencies required by the module

        class { 'wget':
          dependency_class => 'site::wget_dependency',
        }


* Automatically include a custom class with extra resources related to wget.
  Here is loaded $modulepath/example42/manifests/my_wget.pp.
  Note: Use a subclass name different than wget to avoid order loading issues.

        class { 'wget':
         my_class => 'site::wget_my',
        }

## TESTING
[![Build Status](https://travis-ci.org/stdmod/puppet-wget.png?branch=master)](https://travis-ci.org/stdmod/puppet-wget)
