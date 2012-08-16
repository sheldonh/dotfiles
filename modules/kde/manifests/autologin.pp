class kde::autologin($user) {

  include kde

  exec { 'enable-kde-autologin':
    command => "sed -i -e 's/^AutoLoginEnable=false/AutoLoginEnable=true/' /etc/kde/kdm/kdmrc",
    unless  => "grep '^AutoLoginEnable=true' /etc/kde/kdm/kdmrc",
  }

  exec { 'set-kde-autologin-user':
    command => "sed -i -e 's/^AutoLoginUser=.*/AutoLoginUser=$user/' /etc/kde/kdm/kdmrc",
    unless  => "grep '^AutoLoginUser=$user' /etc/kde/kdm/kdmrc",
  }

}
