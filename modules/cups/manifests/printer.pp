define cups::printer($driver = false, $driver_package = false, $address, $cups_default = false) {

  if $driver_package {
    if !defined( Package[$driver_package] ) { package { $driver_package: ensure => installed } }

    Package[$driver_package] -> Exec["add-printer-$name"]
  }

  if $driver {
    if $driver =~ /^https?:\/\/.+\/([^\/]+)$/ {
      $driver_filename = "/usr/src/$1"
      exec { "fetch-$driver":
        command => "curl -L -o $driver_filename $driver",
        creates => $driver_filename,
        before  => Exec["add-printer-$name"],
      }
    } else {
      $driver_filename = $driver
    }
    $driver_opts = "-P $driver_filename"
  } else {
    $driver_opts = ''
  }

  if $cups_default {
    $command = "lpadmin -p $name -v socket://$address/ $driver_opts -E && lpadmin -d $name"
  } else {
    $command = "lpadmin -p $name -v socket://$address/ $driver_opts -E"
  }

  exec { "add-printer-$name":
    command => $command,
    creates => "/etc/cups/ppd/$name.ppd",
  }

}
