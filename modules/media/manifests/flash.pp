class media::flash {

  exec { 'adobe-release-repo':
    command => 'yum install -y http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm',
  }

  if !defined( Package['alsa-plugins-pulseaudio'] ) { package { 'alsa-plugins-pulseaudio': ensure => installed } }
  if !defined( Package['libcurl'] ) { package { 'libcurl': ensure => installed } }

  package { [ 'flash-plugin', 'nspluginwrapper' ]:
    ensure  => installed,
    require => [ Exec['adobe-release-repo'], Package['alsa-plugins-pulseaudio'], Package['libcurl'] ],
  }

}
