azure_credentials_for_authenticatuon  = {

       azure_subscription_id     = ""

       azure_client_id           = ""

       azure_client_secret       = ""

       azure_tenant_id           = ""
}


vm-configuration  = {  

         vm_username            =  "testuser"
         vm_password            =  "test@1234"
         vm_names               =  [ 
                                     "sapvm001-vm", 
                                     "sapvm002-vm", 
                                     "sapvm003-vm", 
                                     "sapvm004-vm", 
                                     "sapvm005-vm", 
                                     "sapvm006-vm", 
                                     "sapvm007-vm",
                                     "sapvm008-vm", 
                                     "sapvm009-vm"
                                   ]
         vm_os_disk_names       =  [
                                     "sapvm001-OSDisk", 
                                     "sapvm002-OSDisk",
                                     "sapvm003-OSDisk", 
                                     "sapvm004-OSDisk", 
                                     "sapvm005-OSDisk", 
                                     "sapvm006-OSDisk", 
                                     "sapvm007-OSDisk", 
                                     "sapvm008-OSDisk", 
                                     "sapvm009-OSDisk"
                                   ]
         vm_sizes               =  [
                                     "Standard_DS2_v2", 
                                     "Standard_DS1_v2", 
                                     "Standard_B1s", 
                                     "Standard_F2s_v2",
                                     "Standard_B1s", 
                                     "Standard_DS1_v2",
                                     "Standard_B1s", 
                                     "Standard_F2s_v2", 
                                     "Standard_B1s"   
                                   ]
         vm_datadisk_names      =  [
                                     "sapvm001-DataDisk", 
                                     "sapvm002-DataDisk", 
                                     "sapvm003-DataDisk", 
                                     "sapvm004-DataDisk", 
                                     "sapvm005-DataDisk", 
                                     "sapvm006-DataDisk", 
                                     "sapvm007-DataDisk", 
                                     "sapvm008-DataDisk",
                                     "sapvm009-DataDisk"
                                   ]
         data_disk_sizes_in_gb  =  [
                                     128, 
                                     256,
                                     512, 
                                     256, 
                                     512,
                                     128, 
                                     256, 
                                     512, 
                                     256
                                   ]
         nic_names              =  [
                                     "sapvm001-nic", 
                                     "sapvm002-nic",
                                     "sapvm003-nic", 
                                     "sapvm004-nic",
                                     "sapvm005-nic", 
                                     "sapvm006-nic", 
                                     "sapvm007-nic",
                                     "sapvm008-nic", 
                                     "sapvm009-nic"
                                    ]
         disk_luns              =   [
                                      10, 
                                      15,
                                      20, 
                                      25, 
                                      30,
                                      35,
                                      40, 
                                      45, 
                                      55
                                    ]                             
         publisher              =  "MicrosoftWindowsServer"
         offer                  =  "WindowsServer"
         sku                    =  "2016-Datacenter"
         version                =  "latest"        
}

common_tags = {
  
   "Environment"  =  "Dev"
   "Owner"        = "Venkat"
   "Asset-Id"     = "101098409"

}
