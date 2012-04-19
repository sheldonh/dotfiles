class skype::dependencies {

  package { ['qt-x11.i686', 'libXScrnSaver.i686', 'alsa-plugins-pulseaudio.i686', 'libXv.i686']:
    ensure => installed,
  }

}
