class rpmfusion::free {

  include rpmfusion

  exec { 'rpmfusion-free-repo':
    command => "yum install --nogpgcheck -y http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-${rpmfusion::release}.noarch.rpm",
    creates => '/etc/yum.repos.d/rpmfusion-free.repo',
  }

  Exec['rpmfusion-free-repo'] -> Package <| |>
}
