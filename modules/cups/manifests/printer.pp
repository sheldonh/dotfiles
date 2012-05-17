define cups::printer($driver, $driver_package = false, $address, $cups_default = false) {

  if $driver_package {
    if !defined( Package[$driver_package] ) { package { $driver_package: ensure => installed } }

    Package[$driver_package] -> Exec["add-printer-$name"]
  }

  if $cups_default {
    $command = "lpadmin -p $name -v socket://$address/ -P $driver -E && lpadmin -d $name"
  } else {
    $command = "lpadmin -p $name -v socket://$address/ -P $driver -E"
  }

  exec { "add-printer-$name":
    command => $command,
    creates => "/etc/cups/ppd/$name.ppd",
  }

}
