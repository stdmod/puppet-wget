#
# = Class: wget::service
#
# This class manages wget service
#
class wget::service {

  if $wget::service {
    service { $wget::service:
      ensure     => $wget::managed_service_ensure,
      enable     => $wget::managed_service_enable,
      subscribe  => $wget::service_subscribe,
      provider   => $wget::service_provider,
      noop       => $wget::noop,
    }
  }

}
