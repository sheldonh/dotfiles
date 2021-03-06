Exec {
  path    => '/bin:/sbin:/usr/bin:/usr/sbin',
  timeout => 0,
}

include ansible
include google_talk
include chrome
include java
include kerberos
include media::flash
include media::mp3
#include media::pdf
include mongodb
include mysql
include rpmfusion::nonfree
include skype
include vpn::hetzner
include yum

package { 'ack': ensure => installed }
package { 'aggregate': ensure => installed }
package { 'clusterssh': ensure => installed }
package { 'firefox': ensure => installed }
package { [ 'git', 'gitk' ]: ensure => installed }
package { 'graphviz': ensure => installed }
package { 'haskell-platform': ensure => installed }
package { 'hexchat': ensure => installed }
package { 'hlint': ensure => installed }
package { 'iotop': ensure => installed }
package { 'lame': ensure => installed }
package { 'links': ensure => installed }
package { 'liveusb-creator': ensure => installed }
package { 'moreutils': ensure => installed }
package { 'mplayer': ensure => installed }
package { 'net-tools': ensure => installed }
package { 'pastebinit': ensure => installed }
package { 'picard': ensure => installed }
package { 'pssh': ensure => installed }
package { 'pwgen': ensure => installed }
package { 'python-keystoneclient': ensure => installed }
package { 'python-novaclient': ensure => installed }
package { 'redis': ensure => installed }
package { 'qt-recordmydesktop': ensure => installed }
package { 'sipcalc': ensure => installed }
package { 'strace': ensure => installed }
package { 'swaks': ensure => installed }
package { 'telnet': ensure => installed }
package { 'tmux': ensure => installed }
package { 'unrar': ensure  => installed }
package { 'vim-command-t': ensure => installed }
package { 'vim-enhanced': ensure => installed }
package { 'whois': ensure => installed }
package { 'wireshark-gnome': ensure => installed }
package { 'words': ensure => installed }
package { 'xorg-x11-fonts-misc': ensure => installed }
package { 'yum-plugin-fastestmirror': ensure => installed }

nodejs::package { ['coffee-script', 'grunt-cli', 'mocha']: ensure => installed }

if $domain == 'hetzner.africa' {
  include hetzner::aaapi
  include hetzner::hetzner_api
  include hetzner::konsoleh
  include hetzner::orderman
  include hetzner::password_resetter
  include hetzner::regprox

  class { 'vagrant':
    host_address   => '10.0.0.1/24',
    host_interface => 'vboxnet0',
  }

  package { 'gmpc': ensure => installed }

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

  if $hostname == 'wrox' {
    mount::ntfs { '/media/windows':
      device => '/dev/sda2',
    }
  }

  include cups::canon_ufr2

  cups::printer { 'MF4570dn':
    driver       => '/usr/share/cups/model/CNCUPSMF4500ZK.ppd',
    address      => 'canon.hearnlan',
    cups_default => true,
    require      => Class['cups::canon_ufr2'],
  }
}

if $::virtual == 'physical' {
  user { 'sheldonh':
    groups  => ['wheel', 'dialout', 'pulse', 'pulse-access', 'wireshark'],
    require => Package['wireshark-gnome'],
  }
} else {
  # Ugh. It's a bit crap that this can't be done in the vagrant module.
  user { 'sheldonh':
    groups  => ['wheel', 'dialout', 'pulse', 'pulse-access', 'vboxusers', 'wireshark'],
    require => Package['wireshark-gnome'],
  }
}

users::dropbox { 'sheldonh': }
users::rpmbuild { 'sheldonh': }
users::rvm { 'sheldonh': gems => [ 'cheat', 'gist' ] }
users::dotfiles { 'sheldonh':
  files => [
    'ackrc',
    'bash_profile',
    'bashrc',
    'bundle/config',
    'config/gmpc/gmpc.cfg',
    'config/gmpc/profiles.cfg',
    'emacs.d/init.el',
    'gemrc',
    'gitconfig',
    'gitignore',
    'kde/share/apps/konsole/konsoleui.rc',
    'kde/share/apps/konsole/Railscasts.colorscheme',
    'kde/share/apps/konsole/Shell.profile',
    'kde/share/apps/konsole/Solarized Dark.colorscheme',
    'kde/share/apps/konsole/Solarized Light.colorscheme',
    'local/share/applications/jetbrains-rubymine.desktop',
    'RubyMine40/config/colors/Solarized Dark.xml',
    'RubyMine40/config/colors/Solarized Light.xml',
    'ssh/config',
  ],
}
users::dotfile { ['kde/Autostart/ssh-add.sh', 'kde/env/gpgagent.sh', 'kde/shutdown/gpgagent.sh']:
  user => sheldonh,
  mode => '0755',
}
users::dotfile { ['gistrc', 'netrc', 'trc']:
  user => sheldonh,
  mode => '0600',
}

users::dotfile { 'rvm/hooks/after_cd_setps1':
  user    => sheldonh,
  mode    => '0755',
  require => Users::Rvm['sheldonh'],
}

# Favor developer convenience over security

users::dotfile { 'ansible.cfg':
  user => sheldonh,
}

file { '/home/sheldonh/.rvm/hooks/after_cd':
  mode    => '0755',
  require => Users::Rvm['sheldonh'],
}

users::script { [ 'sheldonh/hub', 'sheldonh/push-gems', 'sheldonh/rump-prep', 'sheldonh/s', 'sheldonh/git-ksshaskpass',
                  'sheldonh/make-password' ]: }

#rubymine::user { 'sheldonh': }

# Services that slow the boot process for no benefit to me
service { [ 'iscsi', 'iscsid', 'sendmail' ]: enable => false }

class { 'kde::autologin': user => sheldonh }
