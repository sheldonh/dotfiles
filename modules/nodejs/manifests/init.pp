class nodejs {

  exec { 'install-nodejs':
    command => 'yum install -y --enablerepo=updates-testing nodejs',
    unless => 'rpm -q nodejs',
  }

}
