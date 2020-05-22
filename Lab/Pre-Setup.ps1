# New VM
New-VHD “c:\Program Files\Microsoft Learning\Drives\TM-CL1\TM-CL1.vhd” -ParentPath “c:\Program Files\Microsoft Learning\Base\Base20A-W10-1903.vhd”
New-VM –Name TM-CL1 –MemoryStartupBytes 2048MB –VHDPath “c:\Program Files\Microsoft Learning\Drives\TM-CL1\TM-CL1.vhd” –SwitchName “Internet”
