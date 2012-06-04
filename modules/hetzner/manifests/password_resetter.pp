class hetzner::password_resetter {

  if ! defined( Package['libsqlite3x-devel'] ) { package { 'libsqlite3x-devel': ensure => installed } }

}
