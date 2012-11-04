class rubymine {

  $version = '4.5.4'
  $userdir = '.RubyMine40'
  $keyfile = 'rubymine40.key'

  exec { 'install-rubymine':
    command => "curl -L http://download.jetbrains.com/ruby/RubyMine-${version}.tar.gz | tar -C /usr/local -xzf -",
    creates => "/usr/local/RubyMine-${version}",
  }

  exec { 'create-rubymine-dir-symlink':
    command => "ln -fs /usr/local/RubyMine-${version} /usr/local/RubyMine",
    unless  => "ls -ld /usr/local/RubyMine | grep RubyMine-${version}",
    require => Exec['install-rubymine'],
  }

  file { '/usr/local/bin/rubymine':
    ensure => link,
    target => '/usr/local/RubyMine/bin/rubymine.sh',
    require => Exec['create-rubymine-dir-symlink'],
  }

  exec { 'increase-init-max-user-matches':
    command => "echo 'fs.inotify.max_user_watches = 524288' >> /etc/sysctl.conf && sysctl -e -p",
    unless  => "grep '^fs.inotify.max_user_watches = 524288' /etc/sysctl.conf",
  }

}
