class nodejs::npm {

  include nodejs

  package { 'npm':
    ensure  => installed,
    require => Class['nodejs'],
  }

}
