class media::pdf {

  exec { 'adobe-release-i386':
    command => 'yum install -y http://linuxdownload.adobe.com/adobe-release/adobe-release-i386-1.0-1.noarch.rpm',
    creates => '/etc/yum.repos.d/adobe-linux-i386.repo',
  }

  package { 'AdobeReader_enu':
    ensure  => installed,
    require => Exec['adobe-release-i386'],
  }

}
