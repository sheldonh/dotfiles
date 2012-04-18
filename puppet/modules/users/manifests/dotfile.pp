define users::dotfile($user, $home = "/home/$user", $mode = '0644') {

  file { $name:
    path   => "$home/.$name",
    owner  => $user,
    group  => $user,
    mode   => $mode,
    source => ["puppet:///modules/users/$user/dotfiles/$name.md", "puppet:///modules/users/$user/dotfiles/$name"],
  }

}
