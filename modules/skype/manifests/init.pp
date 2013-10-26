class skype {

  include skype::dependencies

  $version = '4.2.0.11'

  exec { 'install-skype':
    command => "yum install --nogpgcheck -y http://download.skype.com/linux/skype-${version}-fedora.i586.rpm",
    unless  => "rpm -q skype-${version}",
    require => Class['skype::dependencies'],
  }

}
