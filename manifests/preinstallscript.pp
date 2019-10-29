define csit::preinstallscript (
                                $pkgname = $name,
                                $ensure  = 'present',
                                $replace = true,
                                $owner   = 'root',
                                $group   = 'root',
                                $mode    = '0755',
                                $source  = undef,
                                $content = undef,
                                $creates = "${csit::srcdir}/preinstall-${pkgname}.installed",
                              ) {
  include ::csit

  if($source==undef and $content==undef)
  {
    fail("csit::preinstallscript(${pkgname}): either source or content must be defined")
  }

  file { "${::csit::srcdir}/preinstall-${pkgname}":
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
    exec { "preinstall script ${pkgname}":
      command => "${::csit::srcdir}/preinstall-${pkgname}",
      creates => $creates,
      require => File["${csit::srcdir}/preinstall-${pkgname}"],
      tag     => "preinstallscript-${pkgname}",
    }
  }
}
