define users::script($group = false, $home = false) {

  $fields = split($name, '/')
  $user = $fields[0]
  $script = $fields[1]

  if $home {
    $path = "$home/bin"
  } else {
    $path = "/home/$user/bin"
  }

  if $group {
    $bingroup = $group
  } else {
    $bingroup = $user
  }

  if !defined( File[$path] ) {
    file { $path:
      ensure => directory,
      owner  => $user,
      group  => $bingroup,
      mode   => '0755',
    }
  }

  file { "$path/$script":
    owner   => $user,
    group   => $bingroup,
    mode    => '755',
    source  => "puppet:///modules/users/$user/bin/$script",
  }

}
