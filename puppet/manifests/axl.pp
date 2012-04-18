Exec {
  path => '/bin:/sbin:/usr/bin:/usr/sbin',
}

include kerberos
include vagrant

package { 'git': ensure => installed }
package { 'vim-enhanced': ensure => installed }
package { 'xchat': ensure => installed }

user { 'sheldonh': }
users::rvm { 'sheldonh': }
users::dotfiles { 'sheldonh':
  files => [
    'bashrc',
    'bash_profile',
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
