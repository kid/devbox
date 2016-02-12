# -*- mode: ruby -*-
# vi: set ft=ruby :

require "pathname"

Vagrant.configure(2) do |config|

  config.vm.box = "archlinux"

  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.customize [
      "modifyvm", :id,
      "--cpus", 4,
      "--pae", "on",
      "--clipboard", "bidirectional"
    ]
  end

  # Install personal ssh key
  config.vm.provision :file, source: "~/.ssh/id_rsa", destination: "/home/vagrant/.ssh/id_rsa"
  config.vm.provision :file, source: "~/.ssh/id_rsa.pub", destination: "/home/vagrant/.ssh/id_rsa.pub"
  config.vm.provision :shell, inline: "fgrep -qf .ssh/id_rsa.pub .ssh/authorized_keys || cat .ssh/id_rsa.pub >> .ssh/authorized_keys"
  config.vm.provision :shell, inline: "chmod 600 .ssh/id_rsa .ssh/id_rsa.pub"

  # Install configs
  config.vm.provision :file, source: "configs", destination: "/tmp/"
  config.vm.provision :shell, inline: "cp -r /tmp/configs/.[^.]* /home/vagrant", privileged: false

  # Run provisioning
  config.vm.provision :shell, path: "provision.sh", privileged: false
  config.vm.provision :shell, inline: "vim -T dumb +PlugInstall +qall", privileged: false
end
