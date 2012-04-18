define users::dotfiles($files = [], $home = "/home/$name", $mode = '0644') {

  users::dotfile{ $files:
    user => $name,
    home => $home,
    mode => $mode,
  }

}
