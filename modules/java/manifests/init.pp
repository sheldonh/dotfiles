class java {

  include wget

  package { 'java-1.8.0-openjdk-devel': ensure => installed }

  $javabin = '/usr/lib/jvm/jre-1.8.0-openjdk.x86_64/bin/java'

  exec { 'use-java-1.8.0-openjdk':
    command => "alternatives --set java $javabin",
    unless  => "alternatives --display java | grep -Fq 'link currently points to $javabin'",
    require => Package['java-1.8.0-openjdk-devel'],
  }

}
