define users::gconfs($confs = [], $group = $name, $home = "/home/$name") {

  $user = $name

  users::gconf { $confs:
    user  => $user,
    group => $group,
    home  => $home,
  }

}
