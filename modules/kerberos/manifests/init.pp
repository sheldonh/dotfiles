class kerberos {
  package { 'krb5-workstation': ensure => installed }

  file { '/etc/krb5.conf':
    owner => root,
    group => root,
    mode  => '0644',
    source => 'puppet:///modules/kerberos/krb5.conf',
  }
}
