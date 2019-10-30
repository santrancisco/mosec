Vagrant::Config.run do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.network :private_network, ip: "192.168.33.23"
  config.vm.customize ["modifyvm", :id, "--memory", 4096]
  config.vm.customize ["modifyvm", :id, "--usb", "on"] # for adb
  config.vm.customize ["modifyvm", :id, "--usbehci", "on"]
  config.vm.share_folder "shared", "/home/vagrant/shared", "./shared"

  puts 'Adding Google Pixel, TPLINK and RALINK usb wifi to Vagrant box'
  
  better_usbfilter_add(config.vm, '0x18d1','0x4ee7','Pixel XL')
  #better_usbfilter_add(config.vm, '0x148f','0x3070','RALINK')
  #better_usbfilter_add(config.vm, '0x0bda','0x8178','TPLINK')
  #better_usbfilter_add(config.vm, '0x148f','0x2770','RALINK2')

  config.vm.provision :shell, :path => "setup.sh", :env => {"MYVAR" => "value"}
  #config.vm.linked_clone => true
end

def usbfilter_exists(vendor_id, product_id)
  #
  # Determine if a usbfilter with the provided Vendor/Product ID combination
  # already exists on this VM.
  #
  # TODO: Use a more reliable way of retrieving this information.
  #
  # NOTE: The "machinereadable" output for usbfilters is more
  #       complicated to work with (due to variable names including
  #       the numeric filter index) so we don't use it here.
  #
  machine_id_filepath = ".vagrant/machines/default/virtualbox/id"

  if not File.exists? machine_id_filepath
    # VM hasn't been created yet.
    return false
  end

  vm_info = `VBoxManage showvminfo $(<#{machine_id_filepath})`
  filter_match = "VendorId:                    #{vendor_id}\nProductId:                   #{product_id}\n"
  return vm_info.include? filter_match
end

def better_usbfilter_add(vb, vendor_id, product_id, filter_name)
  #
  # This is a workaround for the fact VirtualBox doesn't provide
  # a way for preventing duplicate USB filters from being added.
  #
  # TODO: Implement this in a way that it doesn't get run multiple
  #       times on each Vagrantfile parsing.
  #
  if not usbfilter_exists(vendor_id, product_id)
    vb.customize ["usbfilter", "add", "0",
                  "--target", :id,
                  "--name", filter_name,
                  "--vendorid", vendor_id,
                  "--productid", product_id
                  ]
  end
end
