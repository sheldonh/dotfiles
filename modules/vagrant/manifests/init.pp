class vagrant {

  if $::virtual == 'physical' {
    include virtualbox

    # As of puppet-2.7.13, the yum provider doesn't support the source package parameter.
    exec { 'install-vagrant':
      command => 'yum install -y http://files.vagrantup.com/packages/41445466ee4d376601fd8d0c6a5e3af61d32f131/vagrant_1.0.2_x86_64.rpm',
      creates => '/opt/vagrant/bin/vagrant',
      require => Class['virtualbox'],
    }
  } else {
    notice("Refusing to provision vagrant on virtual platform '$::virtual'")
  }

}
