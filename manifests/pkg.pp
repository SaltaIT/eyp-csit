define csit::pkg(
                  $pkgname  = $name,
                  $ensure   = 'installed',
                  $source   = undef,
                  $content  = undef,
                  $provider = undef,
                ) {
  include ::csit

  case $::osfamily
  {
    'redhat':
    {
      $repoprovider = 'rpm'
    }
    'Debian':
    {
      $repoprovider = 'dpkg'
    }
    default:
    {
      $repoprovider = 'rpm'
    }
  }

  if($content!=undef)
  {
    file { "${::csit::srcdir}/pkg-${pkgname}.${repoprovider}":
      ensure  => 'present',
      owner   => 'root',
      group   => 'root',
      mode    => '0640',
      content => $content,
      require => Class['::csit'],
    }

    package { $pkgname:
      ensure   => $ensure,
      source   => "${::csit::srcdir}/pkg-${pkgname}.${repoprovider}",
      provider => $repoprovider,
      require  => File["${::csit::srcdir}/pkg-${pkgname}.${repoprovider}"],
    }
  }
  else
  {
    package { $pkgname:
      ensure   => $ensure,
      source   => $source,
      provider => $provider,
    }
  }

  Exec <| tag == "preinstallscript-${pkgname}" |> ->
  Package[$pkgname] ->
  Exec <| tag == "postinstallscript-${pkgname}" |>

}
