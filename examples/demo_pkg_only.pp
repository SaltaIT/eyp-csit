
cist::pkg { 'csitdemo':
  source => file('csit/demo/csitdemo-3.14.15_926_53_59-1.noarch.rpm'),
}

cist::preinstallscript { 'csitdemo':
  source => file('csit/demo/preinstalldemo.sh'),
}
