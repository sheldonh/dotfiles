define rubymine::user($group = $name, $home = "/home/$name") {

  include rubymine

  $keydir = "${home}/${rubymine::userdir}/config"
  $keyfile = "${keydir}/${rubymine::keyfile}"
  $user = $name

  exec { "create-rubymine-keydir-for-$user":
    command => "su -s /bin/sh -l $user -c 'mkdir -p $keydir'",
    creates => $keydir,
  }

  file { $keyfile:
    owner  => $user,
    group  => $group,
    mode   => '0600',
    source => ["puppet:///modules/users/${user}/rubymine/${rubymine::keyfile}.enc",
               "puppet:///modules/users/${user}/rubymine/${rubymine::keyfile}"],
  }

  Class['rubymine'] -> Exec["create-rubymine-keydir-for-$user"] -> File[$keyfile]

}
