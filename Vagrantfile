Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"  
  config.vm.hostname = "ubuntu-nginx"
  config.vm.network "forwarded_port", guest: 80, host: 5000
  config.vm.network "forwarded_port", guest: 22, host: 2223

  config.vm.provider "virtualbox" do |vb|
	vb.name = "ubuntu-nginx"
    vb.gui = true
    vb.cpus = 1
    vb.memory = "2048"
	#vb.customize ['modifyvm', :id, '--nested-hw-virt', 'on']
  end

  config.vm.provision "shell" do |shell|
    shell.path = "script.sh"
  end
end