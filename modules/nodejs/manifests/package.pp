define nodejs::package($ensure = 'installed') {

  include nodejs::npm

  case $ensure {
    'absent': {
      exec { "npm-uninstall-$name":
        command => "npm uninstall -g $name",
        onlyif  => "npm ls -g 2>/dev/null | grep ' ${name}@'",
        require => Class['nodejs::npm'],
      }
    }
    'installed': {
      exec { "npm-install-$name":
        command => "npm install -g $name",
        unless  => "npm ls -g 2>/dev/null | grep ' ${name}@'",
        require => Class['nodejs::npm'],
      }
    }
    default: {
      fail("unsupported ensure '$ensure'")
    }
  }

}
