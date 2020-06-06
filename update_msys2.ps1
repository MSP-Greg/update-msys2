<#

#>

$env:Path = "C:/msys64/usr/bin;$env:Path"
$conf     = "C:/msys64/etc/pacman.conf"
$args     = '--noconfirm', '--needed', '--noprogressbar'

if ($env:MSYSTEM -match 'mingw32') {
  $pre = 'mingw-w64-i686'
} elseif ($env:MSYSTEM -match 'mingw64') {
  $pre = 'mingw-w64-x86_64'
} else {
  echo Incorrect MSYSTEM value!
  exit 1
}

# stop pacman disk space checks
$raw = $(Get-Content -Path $conf -Raw) -replace '(?m)^CheckSpace', '#CheckSpace'
Out-File -FilePath $conf -InputObject $raw

$msys_pkgs = 'msys2-runtime', 'pacman'
pacman.exe -Sy $args $msys_pkgs
taskkill /f /fi "MODULES eq msys-2.0.dll"

pacman.exe -Sy $args $msys_pkgs
taskkill /f /fi "MODULES eq msys-2.0.dll"

$msys_pkgs = 'base', 'base-devel', 'compression'
Write-Host "pacman.exe -S $args $msys_pkgs"
pacman.exe -S $args $msys_pkgs

pacman.exe -S $args $pre-toolchain
