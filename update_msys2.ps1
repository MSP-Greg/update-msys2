<#

#>
$env:Path = "C:/msys64/usr/bin;$env:Path"
$conf = "C:/msys64/etc/pacman_.conf"

$raw = $(Get-Content -Path $conf -Raw) -replace '(?m)^CheckSpace', '#CheckSpace'
Out-File -FilePath $conf -InputObject $raw

$args = "--noconfirm", "--needed", "--noprogressbar"

pacman.exe -Sy $args msys2-runtime pacman
taskkill /f /fi "MODULES eq msys-2.0.dll"

pacman.exe -Sy $args msys2-runtime pacman
taskkill /f /fi "MODULES eq msys-2.0.dll"

pacman.exe -S $args base base-devel compression
pacman.exe -S $args mingw-w64-x86_64-toolchain
