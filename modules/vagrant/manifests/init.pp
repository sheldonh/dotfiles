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
      command => 'yum install -y http://files.vagrantup.com/packages/be0bc66efc0c5919e92d8b79e973d9911f2a511f/vagrant_1.0.5_x86_64.rpm',
      creates => '/opt/vagrant/bin/vagrant',
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
