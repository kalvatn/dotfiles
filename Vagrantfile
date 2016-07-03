Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/xenial64"

  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.gui = true
    vb.name = "dotfiles_vagrant"
  end

  config.vm.provision "shell" do |sh|
    sh.inline = "apt-get install lubuntu-desktop -y"
  end
end
