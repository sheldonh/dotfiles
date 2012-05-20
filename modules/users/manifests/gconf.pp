define users::gconf($user, $group = $user, $home = "/home/$user") {

  $dumps    = "$home/.gconf-dumps"
  $filename = "$name.xml"

  if ! defined( File[$dumps] ) {
    file { $dumps:
      ensure => directory,
      owner  => $user,
      group  => $group,
      mode   => '0700',
    }
  }

  file { "$dumps/$filename":
    owner   => $user,
    group   => $group,
    mode    => '0700',
    source  => [ "puppet:///modules/users/$user/gconfs/$filename.enc", "puppet:///modules/users/$user/gconfs/$filename" ],
    require => File[$dumps],
  }

  exec { "load-gconf-$name":
    command     => "su -l $user -c 'gconftool-2 --load $dumps/$filename'",
    refreshonly => true,
    subscribe   => File["$dumps/$filename"],
  }

}
