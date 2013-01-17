class yum {

  file { '/etc/yum.conf':
    owner  => root,
    group  => root,
    mode   => 0644,
    source => 'puppet:///modules/yum/yum.conf',
  }

}

Class['yum'] -> Package <| |>
Class['yum'] -> Exec <| |>
