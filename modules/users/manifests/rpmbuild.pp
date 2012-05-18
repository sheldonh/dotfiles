define users::rpmbuild($group = $name, $home = "/home/$name") {

  $user = $name

  if !defined( Package['mock'] ) { package { 'mock': ensure => installed } }
  if !defined( Package['redhat-rpm-config'] ) { package { 'redhat-rpm-config': ensure => installed } }
  if !defined( Package['rpm-build'] ) { package { 'rpm-build': ensure => installed } }

  File {
    owner => $user,
    group => $group,
  }

  exec { "create-rpmbuild-dirs-for-$user":
    command => "su -l $user -c 'mkdir -p $home/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}'",
    creates => "$home/rpmbuild/SRPMS",
    require => User[$user],
  }

  file { "$home/.rpmmacros":
    content => '%_topdir %(echo $HOME)/rpmbuild',
  }

}
