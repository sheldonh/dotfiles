define mount::cifs($user = false, $device, $credential = $user) {

  if !defined( Exec["mkdir -p $name"] ) {
    exec { "mkdir -p $name":
      creates => $name,
    }
  }

  if !defined( File['/etc/cifs'] ) {
    file { '/etc/cifs':
      ensure => directory,
      owner  => root,
      group  => root,
      mode   => '0750',
    }
  }

  if $user {

    $credential_path = "/etc/cifs/${credential}.credential"

    if !defined( File[$credential_path] ) {
      file { $credential_path:
        source  => [ "puppet:///modules/mount/cifs/${credential}.credential.enc",
                     "puppet:///modules/mount/cifs/${credential}.credential" ],
      }
    }

    $mount_authentication = "user=${user},credentials=${credential_path}"
    $mount_dependencies = [ File[$credential_path], Exec["mkdir -p $name"] ]

  } else {
    $mount_authentication = "guest"
    $mount_dependencies = [ Exec["mkdir -p $name"] ]
  }

  mount { $name:
    ensure  => present,
    fstype  => cifs,
    device  => $device,
    options => "rw,${mount_authentication},uid=0,gid=0",
    require => $mount_dependencies,
  }

}
