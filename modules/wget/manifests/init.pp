class wget {

  if !defined(Package['wget']) { package { 'wget': ensure => installed } }

}
