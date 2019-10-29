define csit::service(
                      $pkgname     = $name,
                      $servicename = $name,
                      $ensure      = 'running',
                      $enable      = true,
                    ) {
  include ::csit

  service { $servicename:
    ensure => $ensure,
    enable => $enable,
    tag    => "service-${pkgname}",
  }
}
