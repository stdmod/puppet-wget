#
# = Class: wget::config
#
# This class manages wget configurations
#
class wget::config {

  if $wget::file {
    file { 'wget.conf':
      ensure  => $wget::file_ensure,
      path    => $wget::file,
      mode    => $wget::file_mode,
      owner   => $wget::file_owner,
      group   => $wget::file_group,
      source  => $wget::file_source,
      content => $wget::managed_file_content,
      audit   => $wget::audit,
      noop    => $wget::noop,
    }
  }

  # Configuration Directory, if dir defined
  if $wget::dir_source {
    file { 'wget.dir':
      ensure  => $wget::dir_ensure,
      path    => $wget::dir,
      source  => $wget::dir_source,
      recurse => $wget::dir_recurse,
      purge   => $wget::dir_purge,
      force   => $wget::dir_purge,
      audit   => $wget::audit,
      noop    => $wget::noop,
    }
  }

}
