class vpn::hetzner {

  # Handy variables for when this gets templatized and reused
  $user  = 'sheldonh'
  $group = $user
  $home  = "/home/$user"
  $label = 'Hetzner'
  $ca    = 'ca.crt'
  $cert  = 'sheldon.hearn.crt'
  $key   = 'sheldon.hearn.key'

  $certs = "$home/.cert"

  package { 'NetworkManager-openvpn':
    ensure => installed,
  }

  file { "/etc/NetworkManager/system-connections/$label":
    owner  => root,
    group  => root,
    mode   => '0600',
    source => "puppet:///modules/vpn/$label/${label}.enc",
    require => Package['NetworkManager-openvpn'],
  }

  file { "$certs":
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0700',
  }

  file { "$certs/$ca":
    owner  => $user,
    group  => $group,
    mode   => '0644',
    source => "puppet:///modules/vpn/$label/${ca}.enc",
  }

  file { "$certs/$cert":
    owner  => $user,
    group  => $group,
    mode   => '0644',
    source => "puppet:///modules/vpn/$label/${cert}.enc",
  }

  file { "$certs/$key":
    owner  => $user,
    group  => $group,
    mode   => '0600',
    source => "puppet:///modules/vpn/$label/${key}.enc",
  }

}
