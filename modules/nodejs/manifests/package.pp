define nodejs::package($ensure = 'installed', $source = false) {

  include nodejs::npm

  if $source {
    $target = $source
    if $target =~ /^git:\/\// {
      if !defined( Package['git'] ) { package { 'git': ensure => installed } }
    }
  } else {
    $target = $name
  }

  case $ensure {
    'absent': {
      exec { "npm-uninstall-$name":
        command => "npm uninstall -g $target",
        onlyif  => "npm ls -g 2>/dev/null | grep ' ${name}@'",
        require => Class['nodejs::npm'],
      }
    }
    'installed': {
      exec { "npm-install-$name":
        command => "npm install -g $target",
        unless  => "npm ls -g 2>/dev/null | grep ' ${name}@'",
        require => Class['nodejs::npm'],
      }
    }
    default: {
      fail("unsupported ensure '$ensure'")
    }
  }

}
