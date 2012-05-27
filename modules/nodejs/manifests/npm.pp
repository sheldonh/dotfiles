class nodejs::npm {

  include nodejs

  package { 'npm': ensure => installed }

  Class['nodejs'] -> Package['npm'] -> Nodejs::Package <| |>

}
