define users::gconf($user, $group = $user, $home = "/home/$user") {

  $dumps    = "$home/.gconf-dumps"
  $filename = "$name.xml"

  file { $dumps:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0700',
  }

#  exec { "prepare-gconf-dump-for-$name":
#    command  => "mkdir -p $dumps && find $base -type d -print0 | xargs -0r chmod 700 && chown -R $user:$group $base",
#    provider => shell,
#    creates  => $dump,
#  }

  file { "$dumps/$filename":
    owner   => $user,
    group   => $group,
    mode    => '0700',
    source  => [ "puppet:///modules/users/$user/gconfs/$filename.md", "puppet:///modules/users/$user/gconfs/$filename" ],
    require => File[$dumps],
  }

  exec { "load-gconf-$name":
    command     => "gconftool-2 --load $dumps/$filename",
    refreshonly => true,
    subscribe   => File["$dumps/$filename"],
  }

}
