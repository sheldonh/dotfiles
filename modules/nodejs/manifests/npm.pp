class nodejs::npm {

  include nodejs

  exec { 'install-npm':
    command => 'yum install -y --enablerepo=updates-testing npm',
    unless => 'rpm -q npm',
    require => Class['nodejs'],
  }

}
