class rpmfusion::nonfree {

  include rpmfusion::free

  exec { 'rpmfusion-nonfree-repo':
    command => "yum install -y http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${rpmfusion::release}.noarch.rpm",
    creates => '/etc/yum.repos.d/rpmfusion-nonfree.repo',
    require => Class['rpmfusion::free'],
  }

  Exec['rpmfusion-nonfree-repo'] -> Package <| |>
}
