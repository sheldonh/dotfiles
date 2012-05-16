class media::flash {

  exec { 'adobe-release-x86_64':
    command => 'yum install -y http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm',
    creates => '/etc/yum.repos.d/adobe-linux-x86_64.repo',
  }

  if !defined( Package['alsa-plugins-pulseaudio'] ) { package { 'alsa-plugins-pulseaudio': ensure => installed } }
  if !defined( Package['libcurl'] ) { package { 'libcurl': ensure => installed } }

  package { [ 'flash-plugin', 'nspluginwrapper' ]:
    ensure  => installed,
    require => [ Exec['adobe-release-x86_64'], Package['alsa-plugins-pulseaudio'], Package['libcurl'] ],
  }

}
