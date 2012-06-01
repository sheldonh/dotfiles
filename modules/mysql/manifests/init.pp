class mysql {

  package { 'mysql-server': ensure => installed }

  service { 'mysqld':
    enable => false,
  }

}
