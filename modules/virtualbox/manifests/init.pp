class virtualbox {

  file { '/etc/yum.repos.d/virtualbox.repo':
    owner => root,
    group => root,
    mode  => '0644',
    source => 'puppet:///modules/virtualbox/virtualbox.repo',
  }

  package { 'VirtualBox-4.1':
    ensure  => installed,
    alias   => 'virtualbox',
    require => File['/etc/yum.repos.d/virtualbox.repo'],
  }

  if !defined( Package['dkms'] )         { package { 'dkms': ensure => installed } }
  if !defined( Package['kernel-devel'] ) { package { 'kernel-devel': ensure => installed } }

  # https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=790521
  # Fixed in Fedora 17
  exec { 'fix-redhat-bug-790521':
    command => 'mv /usr/sbin/dkms.old /usr/sbin/dkms',
    creates => '/usr/sbin/dkms',
    onlyif  => '[ -e /usr/sbin/dkms.old ]',
    before  => Exec['setup-virtualbox'],
  }

  exec { 'setup-virtualbox':
    command     => 'if /etc/init.d/vboxdrv setup 2>&1 | grep -q FAILED; then false; else true; fi',
    onlyif      => 'vboxmanage --version 2>&1 | grep -q WARNING',
    provider    => shell,
    require     => Package[['virtualbox', 'dkms', 'kernel-devel']],
  }

}
