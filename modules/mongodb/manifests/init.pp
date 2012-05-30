class mongodb {

  package { 'mongodb-server': ensure => installed }

  service { 'mongod':
    enable => false,
  }

}
