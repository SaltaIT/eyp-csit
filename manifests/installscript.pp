define csit::installscript(
                            $pkgname = $name,
                            $ensure  = 'present',
                            $replace = true,
                            $owner   = 'root',
                            $group   = 'root',
                            $mode    = '0755',
                            $source  = undef,
                            $content = undef,
                            $creates = "${csit::srcdir}/installscript-${pkgname}.installed",
                          ) {
  include ::csit

  file { "${::csit::srcdir}/installscript-${pkgname}":
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
    exec { "installscript script ${pkgname}":
      command => "${::csit::srcdir}/installscript-${pkgname}",
      creates => $creates,
      require => File["${csit::srcdir}/installscript-${pkgname}"],
      tag     => "installscript-${pkgname}",
    }
  }
}
