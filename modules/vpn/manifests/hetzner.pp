class vpn::hetzner {

  # Handy variables for when this gets templatized and reused
  $user  = 'sheldonh'
  $group = $user
  $home  = "/home/$user"
  $label = 'Hetzner'
  $ca    = 'ca.crt'
  $cert  = 'sheldonh.crt'
  $key   = 'sheldonh.key'

  $certs = "$home/.cert"

  package { 'NetworkManager-openvpn':
    ensure => installed,
  }

  file { "/etc/NetworkManager/system-connections/$label":
    owner  => root,
    group  => root,
    mode   => '0600',
    source => "puppet:///modules/vpn/$label/${label}.md",
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
    source => "puppet:///modules/vpn/$label/${ca}.md",
  }

  file { "$certs/$cert":
    owner  => $user,
    group  => $group,
    mode   => '0644',
    source => "puppet:///modules/vpn/$label/${cert}.md",
  }

  file { "$certs/$key":
    owner  => $user,
    group  => $group,
    mode   => '0600',
    source => "puppet:///modules/vpn/$label/${key}.md",
  }

}
