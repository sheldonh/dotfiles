Exec {
  path => '/bin:/sbin:/usr/bin:/usr/sbin',
}

include kerberos

package { 'git': ensure => installed }
package { 'vim-enhanced': ensure => installed }

user { 'sheldonh': }
users::rvm { 'sheldonh': }

