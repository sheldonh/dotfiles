class hetzner::regprox {

  host { 'registrar-proxy':
    ensure  => present,
    name    => 'registrar-proxy.vagrantup.com',
    ip      => '127.0.0.1',
  }

}
