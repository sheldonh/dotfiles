class nodejs {

  exec { 'enable-nodejs-repo':
    command => 'yum install -y http://nodejs.tchol.org/repocfg/fedora/nodejs-stable-release.noarch.rpm',
    creates => '/etc/yum.repos.d/nodejs-stable.repo',
  }

  package { 'nodejs-compat-symlinks': ensure => installed }

  Exec['enable-nodejs-repo'] -> Package <| |>

}
