#CReate Switch Internet

#Client
$NameVM = "TM-CL1" 
New-VHD “c:\Program Files\Microsoft Learning\Drives\$NameVM\$NameVM.vhd” -ParentPath “c:\Program Files\Microsoft Learning\Base\Base20A-W10-1903.vhd”
New-VM –Name $NameVM –MemoryStartupBytes 8196MB  –VHDPath “c:\Program Files\Microsoft Learning\Drives\$NameVM\$NameVM.vhd” –SwitchName “Internet”

Set-VMProcessor $NameVM -Count 2 -Reserve 10 -Maximum 75 -RelativeWeight 200
Set-VMProcessor $NameVM -ExposeVirtualizationExtensions $True


Start-VM $NameVM

#Server
New-VHD “c:\Program Files\Microsoft Learning\Drives\TM-SVR1\TM-SVR1.vhd” -ParentPath “c:\Program Files\Microsoft Learning\Base\Base19D-WS19-1809.vhd”
New-VM –Name TM-SVR1 –MemoryStartupBytes 2048MB –VHDPath “c:\Program Files\Microsoft Learning\Drives\TM-SVR1\TM-SVR1.vhd” –SwitchName “Internet”



# Set Nested
Get-VM

Set-VMProcessor TM-CL1 -ExposeVirtualizationExtensions $True
Set-VMProcessor TM-SVR1 -ExposeVirtualizationExtensions $True

Get-VMProcessor TM-CL1 
Get-VMProcessor TM-SVR1


Set-VMProcessor TM-CL1 -ExposeVirtualizationExtensions $False