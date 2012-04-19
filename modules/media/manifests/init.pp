class media::mp3 {

  exec { 'rpmfusion-free-repo':
    command => 'yum install -y http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm',
    creates => '/etc/yum.repos.d/rpmfusion-free.repo',
  }

  package { 'gstreamer-plugins-ugly':
    ensure  => installed,
    require => Exec['rpmfusion-free-repo'],
  }

}
