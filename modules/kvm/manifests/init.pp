class kvm {

  package { ['qemu-system-x86', 'libvirt', 'virt-manager']: ensure => installed }

  service { 'libvirtd': enable => true }

  Package['libvirt'] -> Service['libvirtd']

}
