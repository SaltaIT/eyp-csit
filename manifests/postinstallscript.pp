define csit::postinstallscript(
                                $pkgname = $name,
                                $ensure  = 'present',
                                $replace = true,
                                $owner   = 'root',
                                $group   = 'root',
                                $mode    = '0755',
                                $source  = undef,
                                $content = undef,
                                $creates = "${csit::srcdir}/postinstall-${pkgname}.installed",
                              ) {
  include ::csit

  file { "${::csit::srcdir}/postinstall-${pkgname}":
    ensure  => $ensure,
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    source  => $source,
    content => $content,
    replace => $replace,
    require => Class['::csit'],
  }

  if($ensure=='present')
  {
    exec { "postinstall script ${pkgname}":
      command => "${::csit::srcdir}/postinstall-${pkgname}",
      creates => $creates,
      require => File["${csit::srcdir}/postinstall-${pkgname}"],
      tag     => "postinstallscript-${pkgname}",
    }
  }
}
