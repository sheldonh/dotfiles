Exec {
  path    => '/bin:/sbin:/usr/bin:/usr/sbin',
  timeout => 0,
}

# google-talkplugin crashing Firefox
#include google_talk
include chrome
include hetzner::aaapi
include hetzner::hetzner_api
include hetzner::konsoleh
include hetzner::password_resetter
include kerberos
include kvm
include media::flash
include media::mp3
include media::pdf
include media::rar
include mongodb
include mysql
include vagrant
include vpn::hetzner

package { 'clusterssh': ensure => installed }
package { 'gimp': ensure => installed }
package { 'git': ensure => installed }
package { 'graphviz': ensure => installed }
package { 'hunspell-en': ensure => installed }
package { 'icedtea-web': ensure => installed }
package { [ 'libreoffice-calc', 'libreoffice-writer' ]: ensure => installed }
package { 'pssh': ensure => installed }
package { 'rdesktop': ensure => installed }
package { 'sipcalc': ensure => installed }
package { 'strace': ensure => installed }
package { 'swaks': ensure => installed }
package { 'telnet': ensure => installed }
package { 'vim-enhanced': ensure => installed }
package { 'whois': ensure => installed }
package { 'wireshark-gnome': ensure => installed }
package { 'words': ensure => installed }
package { 'xchat': ensure => installed }

nodejs::package { 'coffee-script': ensure => installed }
nodejs::package { ['mocha', 'should']: ensure => installed }

if $domain == 'hetzner.africa' {
  # Living without it, to encourage walking around
  #include skype

  package { 'gmpc': ensure => installed }

  mount::cifs { '/media/linsh/stuff':
    user   => 'linsh',
    device => '//linsh/stuff',
  }

  cups::printer { '2600n':
    driver         => '/usr/share/cups/model/HP-Color_LaserJet_1600.ppd.gz',
    driver_package => 'foo2hp',
    address        => '192.168.0.248',
    cups_default   => true,
  }
}
if $fqdn == 'axl.hearnlan' {

  mount::ntfs { '/media/windows':
    device => '/dev/sda2',
  }

  cups::printer { 'X422':
    driver         => 'http://www.cups.org/ppd/lexmark/lexx422.ppd.gz',
    address        => '10.0.0.129',
    cups_default   => true,
  }

}

user { 'sheldonh': }

users::rpmbuild { 'sheldonh': }
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
  user    => sheldonh,
  mode    => '0755',
  require => Users::Rvm['sheldonh'],
}

file { '/home/sheldonh/.rvm/hooks/after_cd':
  mode    => '0755',
  require => Users::Rvm['sheldonh'],
}

users::gconfs { 'sheldonh':
  confs => [ 'gnome-terminal', 'metacity' ],
}

users::script { 'sheldonh/rump-prep': }

rubymine::user { 'sheldonh': }

# Services that slow the boot process for no benefit to me
service { [ 'iscsi', 'iscsid', 'sendmail' ]: enable => false }

