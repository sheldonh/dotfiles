define users::df($group = $name, $home = "/home/$name") {

  $user = $name

  $version = '34_11'
  $src     = "http://www.bay12games.com/dwarves/df_${version}_linux.tar.bz2"
  $dst     = "/usr/src/df_${version}_linux.tar.bz2"

  if !defined( Package['SDL.i686'] ) { package { 'SDL.i686': ensure => installed } }
  if !defined( Package['SDL_image.i686'] ) { package { 'SDL_image.i686': ensure => installed } }
  if !defined( Package['SDL_ttf.i686'] ) { package { 'SDL_ttf.i686': ensure => installed } }
  if !defined( Package['openal-soft.i686'] ) { package { 'openal-soft.i686': ensure => installed } }

  file { "/home/$user/$subdir":
    ensure => directory,
    owner  => $user,
    group  => $group,
  }

  if !defined( Exec['download-df'] ) {
    exec { 'download-df':
      command => "curl -L -o $dst $src",
      creates => $dst,
    }
  }

  exec { "unpack-df-for-$user":
    command => "su -s /bin/bash - $user -c 'cd ~ && tar -xf $dst'",
    creates => "$home/df_linux",
    require => Exec['download-df'],
  }

}
