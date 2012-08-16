define users::dotfile($user, $home = "/home/$user", $mode = '0644') {

  $dotfile = $name

  $dirname = regsubst($dotfile, '^(.+)/([^/]+)$', '\1')
  if $dirname != $dotfile {
    exec { "prepare-dotfile-tree-$user-$name":
      command => "mkdir -p $home/.$dirname",
      creates => "$home/.$dirname",
      provider => shell,
      user     => $user,
      group    => $user,
      before   => File["$user-$dotfile"],
    }
  }

  file { "$user-$dotfile":
    path    => "$home/.$dotfile",
    owner   => $user,
    group   => $user,
    mode    => $mode,
    source  => ["puppet:///modules/users/$user/dotfiles/$dotfile.enc",
                "puppet:///modules/users/$user/dotfiles/$dotfile"],
  }

}
