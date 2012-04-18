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
             'gistrc',
             'rvm/hooks/after_cd_setps1',
           ],
}

exec { 'enable-rvm-hooks':
  command => 'chmod +x /home/sheldonh/.rvm/hooks/after_cd /home/sheldonh/.rvm/hooks/after_cd_setps1',
  unless  => '[ -x /home/sheldonh/.rvm/hooks/after_cd_setps1 ]',
  require => Users::Dotfiles['sheldonh'],
}
