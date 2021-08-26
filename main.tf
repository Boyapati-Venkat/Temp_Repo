resource "azurerm_linux_virtual_machine" "SAP-Sandbox-DB" {
  name                  = var.sap-db-vm-configuration.vm_name
  location              = azurerm_resource_group.SAP-Sandbox-RG.location
  resource_group_name   = azurerm_resource_group.SAP-Sandbox-RG.name
  network_interface_ids = [azurerm_network_interface.SAP-Sandbox-DB-nic.id]
  size                  = var.sap-db-vm-configuration.vm_size

  os_disk {
    name                 = var.sap-db-vm-configuration.vm_os_disk_name
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = var.sap-db-vm-configuration.publisher
    offer     = var.sap-db-vm-configuration.offer
    sku       = var.sap-db-vm-configuration.sku
    version   = var.sap-db-vm-configuration.version
  }

  computer_name                   = var.sap-db-vm-configuration.vm_name
  admin_username                  = var.sap-db-vm-configuration.vm_username
  admin_password                  = var.sap-db-vm-configuration.vm_password
  disable_password_authentication = false

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.mystorageaccount.primary_blob_endpoint
  }

  tags = {
    environment = "SAP-Sandbox-DB"
  }
  
    connection {
      type     = "ssh"
      user     = var.sap-db-vm-configuration.vm_username
      password = var.sap-db-vm-configuration.vm_password 
      host     = azurerm_public_ip.sap-db-ip.ip_address
    }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install opens -y",
      "sudo yum install libnsl -y",
      "sudo yum install uuidd -y",
      "sudo yum install libatomic -y",
      "sudo yum install psmisc -y",
      "sudo yum install libssh2 -y",
      "sudo yum install tcsh -y",
      "sudo yum install nfs-utils -y",
      "sudo yum install krb5-workstation -y",
      "sudo yum install libcanberra-gtk2 -y",
      "sudo yum install libibverbs -y",
      "sudo yum install lm_sensors -y",
      "sudo yum install numactl -y",
      "sudo yum install PackageKit-gtk3-module -y",
      "sudo yum install xorg-x11-xauth -y",
      "sudo yum install tuned-profiles-sap-hana -y",
      "sudo yum install  expect  -y",
      "sudo yum install gtk2 -y",
      "sudo yum install krb5-libs -y",
      "sudo yum install libaio -y",
      "sudo yum install libicu -y",
      "sudo yum install libtool-ltdl -y",
      "sudo yum install openssl -y",
      "sudo yum install rsyslog -y",
      "sudo yum install sudo -y",
      "sudo yum install xfsprogs -y",
      "sudo yum install compat-sap-c++-9-ltdl -y",
      "sudo yum install cairo -y",
      "sudo yum install graphviz -y",
      "sudo yum install iptraf-ng -y",
      "sudo yum install net-tools -y"
      
    ] 
  }
 
}


resource "azurerm_managed_disk" "vm-disks" {
  count = length(var.vm-configuration.vm_datadisk_names)
  name                 = var.vm-configuration.vm_datadisk_names[count.index]
  create_option        = "Empty"
  disk_size_gb         = var.vm-configuration.data_disk_sizes_in_gb[count.index]
  location            = "centralus"
  resource_group_name = "sap-sandbox-rg"
  storage_account_type = "Premium_LRS"
}

resource "azurerm_virtual_machine_data_disk_attachment" "db-disk-attach" {
  count              = length(var.vm-configuration.vm_datadisk_names)
  managed_disk_id    = element(azurerm_managed_disk.vm-disks.*.id, count.index)
  virtual_machine_id = element(azurerm_windows_virtual_machine.windows-vms[*].id, count.index)
  lun                = 0
  caching            = "ReadWrite"
}


resource "azurerm_network_interface" "vm-nics" {
  count = length(var.vm-configuration.nic_names)
  name                = var.vm-configuration.nic_names[count.index]
  location            = "centralus"
  resource_group_name = "sap-sandbox-rg"
  ip_configuration {
    name                          = "testconfiguration"
    subnet_id                     = data.azurerm_subnet.sap-sandbox-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_windows_virtual_machine" "windows-vms" {
  count = length(var.vm-configuration.vm_names )
  name                = var.vm-configuration.vm_names[count.index]
  location            = "centralus"
  resource_group_name = "sap-sandbox-rg"
  size                = var.vm-configuration.vm_sizes[count.index] 
  admin_username      = var.vm-configuration.vm_username
  admin_password      = var.vm-configuration.vm_password
  network_interface_ids = [element(azurerm_network_interface.vm-nics[*].id, count.index)]

  os_disk {
    name                 =  var.vm-configuration.vm_os_disk_names[count.index]
    disk_size_gb         =  var.vm-configuration.data_disk_sizes_in_gb[count.index]
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.vm-configuration.publisher
    offer     = var.vm-configuration.offer
    sku       = var.vm-configuration.sku
    version   = var.vm-configuration.version
  }


  tags = var.common_tags
}





