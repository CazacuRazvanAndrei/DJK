### Prerequsite ! - Create Switch Internet External
https://agup.tech/2015/08/16/the-5-minute-guide-for-docker-on-windows/
# Client
### Create VM Client
```powershell
$NameVM = "TM-CL1" 
New-VHD “c:\Program Files\Microsoft Learning\Drives\$NameVM\$NameVM.vhd” -ParentPath “c:\Program Files\Microsoft Learning\Base\Base20A-W10-1903.vhd”
New-VM –Name $NameVM –MemoryStartupBytes 8196MB  –VHDPath “c:\Program Files\Microsoft Learning\Drives\$NameVM\$NameVM.vhd” –SwitchName “Internet”
```

### Add CPU -Enable Virtualization nested for Client 

```powershell
Set-VMProcessor $NameVM -Count 2 -Reserve 20 -Maximum 85 -RelativeWeight 200
Set-VMProcessor $NameVM -ExposeVirtualizationExtensions $True
```

### Start VM
```powershell
Get-VM
Get-VMProcessor $NameVM
Start-VM $NameVM
```


# Server
```powershell
New-VHD “c:\Program Files\Microsoft Learning\Drives\TM-SVR1\TM-SVR1.vhd” -ParentPath “c:\Program Files\Microsoft Learning\Base\Base19D-WS19-1809.vhd”
New-VM –Name TM-SVR1 –MemoryStartupBytes 2048MB –VHDPath “c:\Program Files\Microsoft Learning\Drives\TM-SVR1\TM-SVR1.vhd” –SwitchName “Internet”
```
