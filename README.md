# Seed Dispenser

Two scripts that generate files that will harvest hashes when a windows machine opens the folder that contains those files, it was inspired the Crop tool from [farmer](https://github.com/mdsecactivebreach/Farmer), I just made them because sometimes I'm too lazy to compile tools or even open a windows box.
Notice that the Crop tool is made to work with other tools becoming way more powerful please check it out if you want something better.

## Usage

```
usage: seed-dispenser.py [-h] [-rl REMOTELOCATION] [-st SEEDTYPE]

Small script that generates a file that when is showed on windows explorer will try to retrieve an
icon from a remote conection, its purpose is to collect NTLMv2 hashes. Supported types scf, url,
searchConnector-ms and library-ms.

optional arguments:
  -h, --help            show this help message and exit
  -rl REMOTELOCATION, --remotelocation REMOTELOCATION
                        IP where the icon will try to load from.
  -st SEEDTYPE, --seedtype SEEDTYPE
                        Type of generated file, the ones available are scf, url, searchConnector-
                        ms and library-ms.
```
Example: ./seed-dispenser.py -rl 192.168.1.250 -st url

For powershell dot source the script and then use:
```
New-Seed -RemoteLocation <IP> -SeedType <type of file>
```

Example New-Seed -RemoteLocation 192.168.1.250 -SeedType lnk

Notice that lnk type is only supported on the powershell version, and has to be used inside a windows box.
If you don't want to dot source the script you can uncomment the last line and execute the script with the proper arguments.

## Known issues

For some reason searchConnector and library-ms files doesn't work when they are generated inside a windows box, the other kinds of files work as they should, if you need any of those files you can use the python version or run the powershell script inside powershell for linux and upload the files where you want.

## TODO

Figure out why searchConnector and library-ms files doesn't work when they are generated on windows and fix it.
