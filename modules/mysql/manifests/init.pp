class mysql {

  package { 'mariadb-server': ensure => installed }

  service { 'mysqld':
    enable => false,
  }

}
