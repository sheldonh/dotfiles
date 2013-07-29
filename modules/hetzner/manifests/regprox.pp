class hetzner::regprox {

  if !defined( Package['libsqlite3x-devel'] ) { package { 'libsqlite3x-devel': ensure => installed } }
  if !defined( Package['libxml2-devel'] ) { package { 'libxml2-devel': ensure => installed } }
  if !defined( Package['libxslt-devel'] ) { package { 'libxslt-devel': ensure => installed } }
  if !defined( Package['mariadb-devel'] ) { package { 'mariadb-devel': ensure => installed } }

  host { 'registrar-proxy':
    ensure  => present,
    name    => 'registrar-proxy.vagrantup.com',
    ip      => '127.0.0.1',
  }

}
