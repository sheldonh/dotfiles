Exec {
  path    => '/bin:/sbin:/usr/bin:/usr/sbin',
  timeout => 0,
}

include kerberos
include vagrant
include vpn::hetzner

package { 'git': ensure => installed }
package { 'graphviz': ensure => installed }
package { 'icedtea-web': ensure => installed }
package { 'vim-enhanced': ensure => installed }
package { 'xchat': ensure => installed }

user { 'sheldonh': }

users::rvm { 'sheldonh': gems => [ 'cheat', 'gist' ] }
users::dotfiles { 'sheldonh':
  files => [
    'bashrc',
    'bash_profile',
    'gemrc',
    'gitconfig',
    'gitignore',
    'ssh/config',
  ],
}
users::dotfile { 'gistrc':
  user => sheldonh,
  mode => '0600',
}

users::dotfile { 'rvm/hooks/after_cd_setps1':
  user => sheldonh,
  mode => '0755',
  require => Users::Rvm['sheldonh'],
}

file { '/home/sheldonh/.rvm/hooks/after_cd':
  mode => '0755',
  require => Users::Rvm['sheldonh'],
}

users::gconfs { 'sheldonh':
  confs => [ 'gnome-terminal' ],
}
