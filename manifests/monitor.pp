#
# = Class: wget::monitor
#
# This class monitors wget
#
class wget::monitor (
  $enable   = $wget::monitor,
  $tool     = $wget::monitor_tool,
  $host     = $wget::monitor_host,
  $protocol = $wget::monitor_protocol,
  $port     = $wget::monitor_port,
  $service  = $wget::service,
  ) inherits wget {

  if $port and $protocol == 'tcp' {
    monitor::port { "wget_${wget::protocol}_${wget::port}":
      ip       => $host,
      protocol => $protocol,
      port     => $port,
      tool     => $tool,
      enable   => $enable,
    }
  }
  if $service {
    monitor::service { 'wget_service':
      service  => $service,
      tool     => $tool,
      enable   => $enable,
    }
  }
}
