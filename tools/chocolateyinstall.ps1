$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url = "https://github.com/springcomp/optimized-azerty-win/releases/download/v1.7.0.0/setup.zip"
$checksum = "9814BF7288A616AC9E8F7AB80AFFEF5704E774D3F1E90F6537FDC4255CB0456B"
$checksumType = "sha256"

# Download setup.zip
Get-ChocolateyWebFile `
  -PackageName $env:ChocolateyPackageName `
  -FileFullPath "$toolsDir\setup.zip" `
  -Url $url `
  -Url64bit $url `
  -Checksum $checksum `
  -ChecksumType $checksumType `
  -Checksum64 $checksum `
  -ChecksumType64 $checksumType

# Extract msi files infside setup.zip
Get-ChocolateyUnzip `
  -FileFullPath "$toolsDir\setup.zip" `
  -FileFullPath64 "$toolsDir\setup.zip" `
  -Destination "$toolsDir\setup\" `
  -PackageName $env:ChocolateyPackageName

# Install msi
Install-ChocolateyInstallPackage `
  -PackageName $env:ChocolateyPackageName `
  -SoftwareName "AZERTY NF Z71-300" `
  -FileType "msi" `
  -SilentArgs "/quiet" `
  -File "$toolsDir\setup\KBFRZ71_i386.msi" `
  -File64 "$toolsDir\setup\KBFRZ71_amd64.msi" `
  -ValidExitCodes @(0)

# Post install cleanup
Remove-Item -Path "$toolsDir\setup" -Recurse
Remove-Item -Path "$toolsDir\setup.zip"
