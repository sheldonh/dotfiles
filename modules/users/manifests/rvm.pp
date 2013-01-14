define users::rvm($home = "/home/$name", $gems = []) {

  $user = $name
  $install = "install-rvm-for-$user"

  if ! defined(Package['gcc-c++']) { package { 'gcc-c++': ensure => installed } }
  if ! defined(Package['patch']) { package { 'patch': ensure => installed } }
  if ! defined(Package['readline']) { package { 'readline': ensure => installed } }
  if ! defined(Package['readline-devel']) { package { 'readline-devel': ensure => installed } }
  if ! defined(Package['zlib']) { package { 'zlib': ensure => installed } }
  if ! defined(Package['zlib-devel']) { package { 'zlib-devel': ensure => installed } }
  if ! defined(Package['libyaml-devel']) { package { 'libyaml-devel': ensure => installed } }
  if ! defined(Package['libffi-devel']) { package { 'libffi-devel': ensure => installed } }
  if ! defined(Package['openssl-devel']) { package { 'openssl-devel': ensure => installed } }
  if ! defined(Package['make']) { package { 'make': ensure => installed } }
  if ! defined(Package['bzip2']) { package { 'bzip2': ensure => installed } }
  if ! defined(Package['autoconf']) { package { 'autoconf': ensure => installed } }
  if ! defined(Package['automake']) { package { 'automake': ensure => installed } }
  if ! defined(Package['libtool']) { package { 'libtool': ensure => installed } }
  if ! defined(Package['bison']) { package { 'bison': ensure => installed } }

  exec { $install:
    command  => 'curl -L get.rvm.io | bash -s stable',
    environment => "HOME=$home",
    provider => shell,
    user     => $user,
    group    => $user,
    creates  => "$home/.rvm",
  }

  if defined(File["${user}-bashrc"]) { Exec[$install] { require +> File["${user}-bashrc"], } }
  if defined(File["${user}-bash_profile"]) { Exec[$install] { require +> File["${user}-bash_profile"], } }

  users::gem { $gems:
    user    => $user,
    home    => $home,
    require => Exec[$install],
  }

  exec { "rvm-pkg-libxml2-for-$user":
    command => "su -s /bin/bash - $user -c 'rvm pkg install libxml2 --verify-downloads 1'",
    unless  => "[ -e $home/.rvm/usr/include/libxml2 ]",
    require => Exec[$install],
  }

  exec { "rvm-pkg-libxslt-for-$user":
    command => "su -s /bin/bash - $user -c 'rvm pkg install libxslt --verify-downloads 1'",
    unless  => "[ -e $home/.rvm/usr/include/libxslt ]",
    require => Exec[$install],
  }

  $patch_symvis = "$home/.rvm/patches/ruby/1.9.3/symbol-visibility-fix.patch"
  file { $patch_symvis:
    owner   => $user,
    group   => $user,
    source  => 'puppet:///modules/users/rvm/symbol-visibility-fix.patch',
    require => Exec[$install],
    before  => Exec["install-ruby1.9-for-$user"],
  }

  exec { "install-ruby1.9-for-$user":
    command  => "su -s /bin/bash - $user -c 'rvm install --docs --default ruby-1.9.3 --patch $patch_symvis'",
    unless   => "[ -h $home/.rvm/rubies/default ]",
    require  => Users::Gem[$gems],
  }

  # https://bugs.ruby-lang.org/issues/6383
  $bugfix6383='CFLAGS="-O2 -fno-tree-dce -fno-optimize-sibling-calls"'

  exec { "install-ruby1.8-for-$user":
    command     => "su -s /bin/bash - $user -c '$bugfix6383 rvm install --docs 1.8.7'",
    unless      => "su -s /bin/bash - $user -c 'rvm list strings | grep ^ruby-1.8.7-'",
    require     => Users::Gem[$gems],
  }

  exec { "install-ree-rg137-for-$user":
    command => "su -s /bin/bash - $user -c '$bugfix6383 rvm install --docs ree -n rg137 && rvm use ree-rg137 && rvm rubygems 1.3.7'",
    unless  => "su -s /bin/bash - $user -c 'rvm list strings | grep ^ree-1.8.7-.*-rg137$'",
    require => Users::Gem[$gems],
  }

}
