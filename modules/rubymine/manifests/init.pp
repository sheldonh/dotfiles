class rubymine {

  $version = '4.5'
  $userdir = '.RubyMine45'
  $keyfile = 'rubymine40.key'

  exec { 'install-rubymine':
    command => "curl -L http://download.jetbrains.com/ruby/RubyMine-${version}.tar.gz | tar -C /usr/local -xzf -",
    creates => "/usr/local/RubyMine-${version}",
  }

  exec { 'create-rubymine-symlink':
    command => "ln -fs /usr/local/RubyMine-${version}/bin/rubymine.sh /usr/local/bin/rubymine",
    unless  => "ls -ld /usr/local/bin/rubymine | grep RubyMine-${version}",
    require => Exec['install-rubymine'],
  }

  exec { 'increase-init-max-user-matches':
    command => "echo 'fs.inotify.max_user_watches = 524288' >> /etc/sysctl.conf && sysctl -p",
    unless  => "grep '^fs.inotify.max_user_watches = 524288' /etc/sysctl.conf",
  }

}
