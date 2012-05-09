class rpmfusion::nonfree {

  exec { 'rpmfusion-nonfree-repo':
    command => 'yum install -y http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-stable.noarch.rpm',
    creates => '/etc/yum.repos.d/rpmfusion-nonfree.repo',
  }

  Exec['rpmfusion-nonfree-repo'] -> Package <| |>
}
