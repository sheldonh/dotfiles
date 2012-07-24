class hetzner::orderman {

  host { 'ordermanager':
    ensure  => present,
    name    => 'ordermanager.vagrantup.com',
    ip      => '127.0.0.1',
  }

}
