class cups::canon_ufr2 {

  $dldir = '/usr/src'
  $zipfile = 'o1113enx_l_ufr220.zip'
  $subdir = 'UK/64-bit_Driver/RPM'
  $common = "cndrvcups-common-2.20-1.x86_64"
  $ufr2 = "cndrvcups-ufr2-uk-2.20-1.x86_64"

  exec { "download-$zipfile":
    command => "wget -O /usr/src/$zipfile http://files.canon-europe.com/files/soft40355/software/$zipfile",
    creates => "$dldir/$zipfile",
  }

  exec { "unpack-$zipfile":
    command => "unzip -u $zipfile $subdir",
    cwd     => $dldir,
    creates => "$dldir/$subdir",
    require => Exec["download-$zipfile"],
  }

  exec { "install-$common":
    command => "rpm -i $subdir/${common}.rpm",
    cwd     => $dldir,
    unless  => "rpm -q $common",
    require => Exec["unpack-$zipfile"],
  }

  exec { "install-$ufr2":
    command => "rpm -i $subdir/${ufr2}.rpm",
    cwd     => $dldir,
    unless  => "rpm -q $ufr2",
    require => Exec["install-$common"],
  }

}
