# vi: set ft=ruby:
Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.ssh.insert_key = false

  config.vm.provider :virtualbox do |vb|
    vb.name = "dotfiles"
    vb.memory = 512
    vb.cpus = 2
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  config.vm.hostname = "dotfiles"
  config.vm.network :private_network, ip: "192.168.33.33"

  config.vm.define :dotfiles do |dotfiles|
  end

  config.vm.synced_folder ".", "/home/vagrant/dotfiles"

  # config.vm.provision "ansible_local" do |ansible|
  #   ansible.playbook = "/home/vagrant/dotfiles/provision/ansible/vagrant-playbook.yml"
  #   ansible.inventory_path = "/home/vagrant/dotfiles/provision/ansible/hosts"
  # end
end
