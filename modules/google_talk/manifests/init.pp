class google_talk {

  exec { 'install-google-talkplugin':
    command => 'yum install -y http://dl.google.com/linux/direct/google-talkplugin_current_x86_64.rpm',
    unless  => 'rpm -q google-talkplugin',
  }

}
