class java {

  file { '/usr/local/bin/install-oracle-jdk':
    owner  => root,
    group  => root,
    mode   => 0755,
    source => 'puppet:///modules/java/install-oracle-jdk',
  }

  exec { 'install-oracle-jdk':
    command => '/usr/local/bin/install-oracle-jdk',
    unless  => '/usr/local/bin/install-oracle-jdk check',
  }

}
