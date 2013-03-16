class chrome {

  file { '/etc/yum.repos.d/google-chrome.repo':
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///modules/chrome/google-chrome.repo',
  }

  package { 'google-chrome-stable':
    ensure => installed,
    require => File['/etc/yum.repos.d/google-chrome.repo'],
  }

}
