class ansible {

  package { 'ansible':
    ensure => present,
  }

  # For using the development version from git:

  if (!defined(Package['python-devel'])) { package { 'python-devel': ensure => present } }
  if (!defined(Package['python-paramiko'])) { package { 'python-paramiko': ensure => present } }
  if (!defined(Package['PyYAML'])) { package { 'PyYAML': ensure => present } }
  if (!defined(Package['python-jinja2'])) { package { 'python-jinja2': ensure => present } }

}
