define mount::ntfs($device) {

  if !defined( Exec["mkdir -p $name"] ) {
    exec { "mkdir -p $name":
      creates => $name,
    }
  }

  mount { $name:
    ensure  => present,
    fstype  => lowntfs-3g,
    device  => $device,
    options => 'defaults',
    require => Exec["mkdir -p $name"],
  }

}
