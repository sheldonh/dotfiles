define mount::cifs($user, $device, $credential = $user) {

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

  $credential_path = "/etc/cifs/${credential}.credential"

  if !defined( File[$credential_path] ) {
    file { $credential_path:
      source  => [ "puppet:///modules/mount/cifs/${credential}.credential.md",
                   "puppet:///modules/mount/cifs/${credential}.credential" ],
    }
  }

  mount { $name:
    ensure  => present,
    fstype  => cifs,
    device  => $device,
    options => "rw,user=$user,credentials=${credential_path},uid=0,gid=0",
    require => [ File[$credential_path], Exec["mkdir -p $name"] ],
  }

}
