#puppet-postgresqlrepo

[![Build Status](https://travis-ci.org/Mylezeem/puppet-postgresqlrepo.svg?branch=master)](https://travis-ci.org/Mylezeem/puppet-postgresqlrepo)

##Overview
A puppet module that configure the PostgreSQL repository on a Linux system.

##Module Description
Based on your system specifications, this module will install a the repository to install PostgreSQL packages.

##Usage

As it simplest, simply include the `postgresqlrepo` class

```puppet
include postgresqlrepo
```

If one wants a specific version of PostgreSQL simply specify it (default is 9.3)

```puppet
class {'postgresqlrepo' :
  version            => '9.1',
  repo_source_enable => true,
}
```
##Parameters

####`version`

Version of the PostgreSQL repo to install. Current Possible values are '8.4', '9.0', '9.1', 9.2', '9.3' (default) and '9.4'

####`repo_enable`

Whether or not to enable the main PostgreSQL repository (boolean)

####`repo_source_enable`

Whether or not to enable the source PostgreSQL repository (boolean)

##Limitations

This module works for :

* EL5
* EL6
* Fedora 19/20
* Debian 6/7/8
* Ubuntu 10.04/12.04/14.04/14.10
