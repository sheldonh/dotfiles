define mount::ntfs($device) {

  if !defined( Exec["mkdir -p $name"] ) {
    exec { "mkdir -p $name":
      creates => $name,
      onlyif  => "ntfslabel $device",
    }
  }

  exec { "ntfs-safety-belt-for-$name":
    command => "test -d $name",
    require => Exec["mkdir -p $name"],
  }

  mount { $name:
    ensure  => present,
    fstype  => lowntfs-3g,
    device  => $device,
    options => 'defaults',
    require => Exec["ntfs-safety-belt-$name"],
  }

}
