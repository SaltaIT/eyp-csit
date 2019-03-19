class csit(
            $srcdir = '/usr/local/src',
          ){
  Exec {
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  exec { "mkdir ${srcdir} csit":
    command => "mkdir -p ${srcdir}",
    creates => $srcdir,
  }
}
