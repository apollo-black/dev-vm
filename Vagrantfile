Vagrant.configure("2") do |config|
  config.vm.box = "apolloblack/dev-vm"
  config.vm.box_check_update = false
  config.vm.network "forwarded_port", guest: 3000, host: 3000 # rails
  config.vm.synced_folder ".", "/vagrant_data"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end

  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    ln -s /vagrant_data ~/app
  SHELL
 end
