define csit::pkg(
                  $pgkname  = $name,
                  $ensure   = 'installed',
                  $source   = undef,
                  $provider = undef,
                ) {
  package { $pkgname:
    ensure => $ensure,
    source   => $source,
    provider => $provider,
  }
}
