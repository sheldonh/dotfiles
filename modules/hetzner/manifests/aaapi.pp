class hetzner::aaapi {

  if ! defined( Package['libxml2-devel'] )    { package { 'libxml2-devel': ensure => installed } }
  if ! defined( Package['libxslt-devel'] )    { package { 'libxslt-devel': ensure => installed } }
  if ! defined( Package['openldap-devel'] )    { package { 'openldap-devel': ensure => installed } }

}
