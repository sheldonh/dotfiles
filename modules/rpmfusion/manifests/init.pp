class rpmfusion {

  if ($::lsbdistrelease == '18') {
    $release = 'branched'
  } else {
    $release = 'stable'
  }

}
