class hetzner::aaapi {

  if ! defined( Package['libxml2-devel'] )    { package { 'libxml2-devel': ensure => installed } }
  if ! defined( Package['libxslt-devel'] )    { package { 'libxslt-devel': ensure => installed } }
  if ! defined( Package['openldap-clients'] ) { package { 'openldap-clients': ensure => installed } }
  if ! defined( Package['openldap-devel'] )   { package { 'openldap-devel': ensure => installed } }
  if ! defined( Package['openldap-servers'] ) { package { 'openldap-servers': ensure => installed } }

  if !defined( Service['slapd'] ) { service { 'slapd': enable => false } }

  host { 'aaapi':
    ensure  => present,
    name    => 'aaapi.vagrantup.com',
    ip      => '127.0.0.1',
  }

}
