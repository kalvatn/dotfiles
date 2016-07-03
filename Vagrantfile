Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/xenial64"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    #vb.gui = true
    vb.name = "dotfiles"
  end

  config.vm.provision "shell" do |sh|
    sh.inline = "apt-get update && apt-get dist-upgrade -y"
  end
end
