class hetzner::hetzner_api {

  if ! defined( Package['libxml2-devel'] )    { package { 'libxml2-devel': ensure => installed } }
  if ! defined( Package['libxslt-devel'] )    { package { 'libxslt-devel': ensure => installed } }
  if ! defined( Package['mysql-devel'] )      { package { 'mysql-devel': ensure => installed } }
  if ! defined( Package['postgresql-devel'] ) { package { 'postgresql-devel': ensure => installed } }

}
