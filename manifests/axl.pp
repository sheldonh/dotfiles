Exec {
  path    => '/bin:/sbin:/usr/bin:/usr/sbin',
  timeout => 0,
}

include hetzner::aaapi
include hetzner::hetzner_api
include hetzner::konsoleh
include kerberos
include media::flash
include media::mp3
include vagrant
include vpn::hetzner

package { 'hunspell-en': ensure => installed }
package { 'git': ensure => installed }
package { 'graphviz': ensure => installed }
package { 'icedtea-web': ensure => installed }
package { 'swaks': ensure => installed }
package { 'telnet': ensure => installed }
package { 'vim-enhanced': ensure => installed }
package { 'xchat': ensure => installed }

if $domain == "hetzner.africa" {
  include skype

  mount::cifs { '/media/linsh/stuff':
    user   => 'linsh',
    device => '//linsh/stuff',
  }
}

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
  confs => [ 'gnome-terminal', 'metacity' ],
}

