define users::gem($user, $group = $user, $home = "/home/$user") {

  $gem = $name

  exec { "rvm-global-gem-${gem}-${user}":
    command => "echo '$gem' >> $home/.rvm/gemsets/global.gems",
    unless  => "grep '^$gem$' $home/.rvm/gemsets/global.gems",
  }

}
