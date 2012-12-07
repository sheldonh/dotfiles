class virtualbox {

  include rpmfusion::free

  package { 'VirtualBox':
    ensure  => installed,
    alias   => 'virtualbox',
    require => Class['rpmfusion::free'],
  }

}
