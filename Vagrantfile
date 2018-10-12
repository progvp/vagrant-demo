# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/bionic64"

  config.vm.hostname = "test-task"

  config.vm.post_up_message = "System installed, open http://localhost:8080 in your browser. Or run 'vagrant ssh' to SSH onto VM"

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network :private_network, ip: "10.150.0.5"

  # config.vbguest.auto_update = false

  # Provisioners

  config.vm.synced_folder "salt/", "/srv/salt/"

  config.vm.provision "shell", inline: "sudo apt-get update && apt-get -y install python-pygit2", run: "always"  # Needed for Salt gitfs support

  config.vm.provision :salt do |salt|
    salt.install_type = "stable"
    salt.bootstrap_options = "-F -c /tmp -P"
    salt.colorize = true
    salt.verbose = true
    salt.always_install = false
    salt.minion_config = "minion"
    salt.run_highstate = true
  end

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--cpus", "4"]
  end

end
