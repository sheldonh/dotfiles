Exec {
  path    => '/bin:/sbin:/usr/bin:/usr/sbin',
  timeout => 0,
}

include google_talk
include chrome
include hetzner::aaapi
include hetzner::hetzner_api
include hetzner::konsoleh
include hetzner::orderman
include hetzner::password_resetter
include java
include kerberos
include media::mp3
include media::pdf
include media::rar
include mongodb
include mysql
include skype
include vagrant
include vpn::hetzner

package { 'ack': ensure => installed }
package { 'clusterssh': ensure => installed }
package { 'firefox': ensure => installed }
package { [ 'git', 'gitk' ]: ensure => installed }
package { 'graphviz': ensure => installed }
package { 'iotop': ensure => installed }
package { 'links': ensure => installed }
package { 'liveusb-creator': ensure => installed }
package { 'pssh': ensure => installed }
package { 'pwgen': ensure => installed }
package { 'qmpdclient': ensure => installed }
package { 'sipcalc': ensure => installed }
package { 'strace': ensure => installed }
package { 'swaks': ensure => installed }
package { 'telnet': ensure => installed }
package { 'vim-enhanced': ensure => installed }
package { 'whois': ensure => installed }
package { 'wireshark-gnome': ensure => installed }
package { 'words': ensure => installed }
package { 'yum-plugin-fastestmirror': ensure => installed }

nodejs::package { 'coffee-script': ensure => installed }
nodejs::package { ['mocha', 'should']: ensure => installed }

if $domain == 'hetzner.africa' {
  mount::cifs { '/media/linsh/stuff':
    user   => 'linsh',
    device => '//linsh/stuff',
  }

  mount::cifs { '/media/whale/shared':
    device => '//whale/shared',
  }

  cups::printer { '2600n':
    driver         => '/usr/share/cups/model/HP-Color_LaserJet_1600.ppd.gz',
    driver_package => 'foo2hp',
    address        => '192.168.0.248',
    cups_default   => true,
  }
}
if $domain == 'hearnlan' {

  mount::ntfs { '/media/windows':
    device => '/dev/sda2',
  }

  mount::cifs { '/media/fatboy/public':
    user       => 'pcguest',
    device     => '//fatboy/public',
    credential => 'fatboy'
  }

  cups::printer { 'X422':
    driver         => 'http://www.cups.org/ppd/lexmark/lexx422.ppd.gz',
    address        => '10.0.0.129',
    cups_default   => true,
  }
}

user { 'sheldonh': }

users::dropbox { 'sheldonh': }
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
    'kde/share/apps/konsole/Railscasts.colorscheme',
    'kde/share/apps/konsole/Shell.profile',
    'kde/share/apps/konsole/Solarized Dark.colorscheme',
    'kde/share/apps/konsole/Solarized Light.colorscheme',
    'kde/share/apps/konsole/konsoleui.rc',
    'RubyMine40/config/colors/Solarized Dark.xml',
    'RubyMine40/config/colors/Solarized Light.xml',
  ],
}
users::dotfile { ['kde/Autostart/ssh-add.sh', 'kde/env/gpgagent.sh', 'kde/shutdown/gpgagent.sh']:
  user => sheldonh,
  mode => '0755',
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

users::script { [ 'sheldonh/push-gems', 'sheldonh/rump-prep', 'sheldonh/s', 'sheldonh/git-ksshaskpass' ]: }

rubymine::user { 'sheldonh': }

# Services that slow the boot process for no benefit to me
service { [ 'iscsi', 'iscsid', 'sendmail' ]: enable => false }

class { 'kde::autologin': user => sheldonh }