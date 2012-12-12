class media::mp3 {

  package { ['gstreamer-ffmpeg', 'gstreamer-plugins-ugly']:
    ensure  => installed,
  }

}
