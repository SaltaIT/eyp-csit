# csit

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What csit affects](#what-csit-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with csit](#beginning-with-csit)
4. [Usage](#usage)
5. [Reference](#reference)
5. [Limitations](#limitations)
6. [Development](#development)
    * [TODO](#todo)
    * [Contributing](#contributing)

## Overview

custom package installation with optional pre and post installation script execution

## Module Description

* **csit::pkg**: you can install custom packages to Debian and RedHat based servers.
* **csit::installscript**: execution of a given script
* **csit::preinstallscript**: exection of a given script before installing **csit::pkg** (pkgname must match)
* **csit::postinstallscript**: exection of a given script after installing **csit::pkg** (pkgname must match)

## Setup

### What csit affects

* /usr/local/src will be used by default as a installation source

### Setup Requirements

This module requires pluginsync enabled

### Beginning with csit

```puppet
csit::pkg { 'csitdemo':
  content => file('csit/demo/csitdemo-3.14.15_926_53_59-1.noarch.rpm'),
}

csit::preinstallscript { 'csitdemo':
  content => file('csit/demo/preinstalldemo.sh'),
}

csit::postinstallscript { 'csitdemo':
  content => file('csit/demo/postinstalldemo.sh'),
}
```

## Usage

Put the classes, types, and resources for customizing, configuring, and doing
the fancy stuff with your module here.

## Reference

Here, list the classes, types, providers, facts, etc contained in your module.
This section should include all of the under-the-hood workings of your module so
people know what the module is touching on their system but don't need to mess
with things. (We are working on automating this section!)

## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Development

We are pushing to have acceptance testing in place, so any new feature should
have some test to check both presence and absence of any feature

### TODO

TODO list

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
