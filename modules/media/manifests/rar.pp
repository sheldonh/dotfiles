class media::rar {

  include rpmfusion::nonfree

  package { 'unrar':
    ensure  => installed,
    require => Class['rpmfusion::nonfree'],
  }

}
