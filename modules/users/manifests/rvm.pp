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

  users::gem { $gems:
    user    => $user,
    home    => $home,
    require => Exec[$install],
  }

  exec { "install-ruby-for-$user":
    command  => "su -s /bin/bash - $user -c 'rvm install --default ruby'",
    creates  => "$home/.rvm/rubies/default",
    require  => Users::Gem[$gems],
  }

}
