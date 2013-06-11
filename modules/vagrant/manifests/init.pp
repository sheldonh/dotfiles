class vagrant($host_address = false, $host_interface = false) {

  if $::virtual == 'physical' {
    if !defined( Package['akmod-VirtualBox'] ) { package { 'akmod-VirtualBox': ensure  => installed } }
    if !defined( Package['VirtualBox'] ) {
      package { 'VirtualBox':
        ensure  => installed,
        require => Package['akmod-VirtualBox'],
      }
    }

    # As of puppet-2.7.13, the yum provider doesn't support the source package parameter.
    exec { 'install-vagrant':
      command => 'yum install -y http://files.vagrantup.com/packages/7e400d00a3c5a0fdf2809c8b5001a035415a607b/vagrant_1.2.2_x86_64.rpm',
      unless  => 'rpm -qa | grep vagrant-1.2.2',
      require => Package['VirtualBox'],
    }

    if ((!$host_address) and (!$host_interface)) {
      # No fancy required
    } else {
      if ((!$host_address) or (!$host_interface)) {
        # Not enough fancy provided
        error('$host_address and $host_interface must be supplied together')
      } else {
        file { '/etc/rc.d/rc.local':
          owner   => root,
          group   => root,
          mode    => '0755',
          content => template('vagrant/rc.local.erb'),
        }

        exec { '/etc/rc.d/rc.local':
          refreshonly => true,
          subscribe   => File['/etc/rc.d/rc.local'],
        }
      }
    }
  } else {
    notice("Refusing to provision vagrant on virtual platform '$::virtual'")
  }

}
