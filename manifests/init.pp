# == Class: postgresqlrepo
#
# A puppet module that configure the PostgreSQL repository on an Enterprise Linux (and relatives) system
#
# === Parameters
#
# [*version*]
#   (float) PostgreSQL version number
#   Possible value: 8.4, 9.0, 9.1, 9.2, 9.3
#   Default: 9.3
#
# [*repo_enable*]
#   (boolean) Should the main repo be enabled
#   Default: true
#
# [*repo_source_enable*]
#   (boolean) Should the srpms repo should be enabled.
#   Default: false
#
# === Examples
#
#  include postgresqlrepo
#
#    or
#
#  class { 'postgresqlrepo' :
#   version             => '9.1',
#   repo_source_enable  => true,
#  }
#
# === Authors
#
# Yanis Guenane <yguenane@gmail.com>
#
# === Copyright
#
# Copyright 2014 Yanis Guenane
#
class postgresqlrepo (
  $version            = '9.3',
  $repo_enable        = true,
  $repo_source_enable = false,
) {

  include stdlib

  if ! ($::operatingsystem in ['RedHat', 'Fedora', 'CentOS']) {
    fail ("This module does not support your operating system : ${::operatingsystem}")
  }

  $os = $::operatingsystem ? {
    /RedHat|CentOS/ => 'redhat',
    'Fedora'        => 'fedora',
  }
  $os_shortname = $::operatingsystem ? {
    /RedHat|CentOS/ => 'rhel',
    'Fedora'        => 'fedora',
  }

  yumrepo { "pgdg${version}" :
    descr    => "PostgreSQL ${version} \$releasever - \$basearch",
    baseurl  => "http://yum.postgresql.org/${version}/${os}/${os_shortname}-\$releasever-\$basearch",
    gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-93',
    gpgcheck => 1,
    enabled  => bool2num($repo_enable),
  }

  yumrepo { "pgdg${version}-source" :
    descr    => "PostgreSQL ${version} \$releasever - \$basearch - Source",
    baseurl  => "http://yum.postgresql.org/srpms/${version}/${os}/${os_shortname}-\$releasever-\$basearch",
    gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-93',
    gpgcheck => 1,
    enabled  => bool2num($repo_source_enable),
  }

}
