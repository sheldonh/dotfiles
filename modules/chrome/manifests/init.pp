class chrome {

  exec { 'install-chrome':
    command => 'yum install -y https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm',
    creates => '/etc/yum.repos.d/google-chrome.repo',
  }

}
