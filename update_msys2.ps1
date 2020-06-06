<#

#>

$env:Path = "C:/msys64/usr/bin;$env:Path"
$conf     = "C:/msys64/etc/pacman.conf"

$raw = $(Get-Content -Path $conf -Raw) -replace '(?m)^CheckSpace', '#CheckSpace'
Out-File -FilePath $conf -InputObject $raw

$args = '--noconfirm', '--needed', '--noprogressbar'

$msys_pkgs = 'msys2-runtime', 'pacman'
pacman.exe -Sy $args $msys_pkgs
taskkill /f /fi "MODULES eq msys-2.0.dll"

pacman.exe -Sy $args $msys_pkgs
taskkill /f /fi "MODULES eq msys-2.0.dll"

$msys_pkgs = 'base', 'base-devel', 'compression'
Write-Host "pacman.exe -S $args $msys_pkgs"
pacman.exe -S $args $msys_pkgs

pacman.exe -S $args mingw-w64-x86_64-toolchain
