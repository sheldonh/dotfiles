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

