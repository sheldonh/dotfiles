class media::mp3 {

  include rpmfusion::free

  package { ['gstreamer-ffmpeg', 'gstreamer-plugins-ugly']:
    ensure  => installed,
    require => Class['rpmfusion::free'],
  }

}
