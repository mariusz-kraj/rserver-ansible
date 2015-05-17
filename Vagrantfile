# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    filename = './vagrant/parameters'
    if !File.exist?(filename) and !File.file?(filename)
        print "Create ./parameters (based on dist)\n"
        exit
    end

    require './vagrant/configuration'
    parameters = Configuration.get_vars(filename)

    hostname = parameters['project'] + ".dev";

    #config.vm.box = "ubuntu/trusty64"
    config.vm.box = "digital_ocean"

    config.vm.boot_timeout = 5000
    config.ssh.forward_agent = true

    config.vm.provider :virtualbox do |provider, override|
        override.vm.hostname = hostname;
        override.vm.synced_folder ".", "/usr/share/nginx/www/app/", :mount_options => ["dmode=777","fmode=666"]

        override.vm.network :private_network, ip: parameters['ip']

        provider.name = parameters['project']
        provider.gui = false
        provider.customize ["modifyvm", :id, "--memory", parameters['memory']]
        provider.customize ["modifyvm", :id, "--cpus", parameters['cpu']]
    end

    config.vm.provider :digital_ocean do |provider, override|
        config.ssh.private_key_path = "C:\\Users\\Mariusz\\.ssh\\id_rsa"
        override.vm.box = 'digital_ocean'
        override.vm.box_url = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"

        provider.token = '__place__your__digitalocean__token__'
        provider.image = 'ubuntu-14-04-x64'
        provider.region = 'ams3'
        provider.size = '1gb'
      end

    config.vm.provision "shell", path: "ansible/provision.sh"
end
