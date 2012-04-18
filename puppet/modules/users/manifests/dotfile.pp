define users::dotfile($user, $home, $mode) {

  file { $name:
    path   => "$home/.$name",
    owner  => $user,
    group  => $user,
    mode   => $mode,
    source => ["puppet:///modules/users/$user/dotfiles/$name.enc", "puppet:///modules/users/$user/dotfiles/$name"],
  }

}