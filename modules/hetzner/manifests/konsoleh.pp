class hetzner::konsoleh {

  if ! defined( Package['libxml2-devel'] )          { package { 'libxml2-devel': ensure => installed } }
  if ! defined( Package['libxslt-devel'] )          { package { 'libxslt-devel': ensure => installed } }
  if ! defined( Package['mariadb-devel'] )          { package { 'mariadb-devel': ensure => installed } }
  if ! defined( Package['openldap-devel'] )         { package { 'openldap-devel': ensure => installed } }
  if ! defined( Package['php-phpunit-PHPUnit'] )    { package { 'php-phpunit-PHPUnit': ensure => installed } }
  if ! defined( Package['postgresql-devel'] )       { package { 'postgresql-devel': ensure => installed } }
  if ! defined( Package['qtwebkit-devel'] )         { package { 'qtwebkit-devel': ensure => installed } }
  if ! defined( Package['xorg-x11-server-Xvfb'] )   { package { 'xorg-x11-server-Xvfb': ensure => installed } }

  host { 'konsoleh':
    ensure  => present,
    name    => 'konsoleh.vagrantup.com',
    ip      => '127.0.0.1',
  }

}
