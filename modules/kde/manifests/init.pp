class kde {

  file { '/etc/sysconfig/desktop':
    content => "DISPLAYMANAGER='kdm'\n",
  }

}
