class rubymine {

  $version = '4.0.3'

  exec { 'install-rubymine':
    command => "curl -L http://download.jetbrains.com/ruby/RubyMine-${version}.tar.gz | tar -C /usr/local -xzf -",
    creates => "/usr/local/RubyMine-${version}",
  }

  exec { 'create-rubymine-symlink':
    command => "ln -fs /usr/local/RubyMine-${version}/bin/rubymine.sh /usr/local/bin/rubymine",
    unless  => "ls -ld /usr/local/bin/rubymine | grep RubyMine-${version}",
    require => Exec['install-rubymine'],
  }

}
