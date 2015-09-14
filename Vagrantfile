VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.network "private_network", ip: "192.168.99.101", nic_type: "82545EM"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
    config.vm.box = "trusty64"
    config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
    vb.customize ["modifyvm", :id, "--memory", "5120"]
    vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
  end

  config.vm.provision :shell, inline: <<-SCRIPT
    sudo -u vagrant sh -c "ln -sfn /vagrant/bin-inner/.bash_profile"
    sudo -u vagrant sh -c "ln -sfn /vagrant/bin-inner/.vimrc"
    sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
    sudo sh -c "echo deb https://apt.dockerproject.org/repo ubuntu-precise main > /etc/apt/sources.list.d/docker.list"
    sudo apt-get update
    sudo apt-get install -y docker-engine linux-image-generic-lts-trusty
    sudo sh -c 'echo "DOCKER_OPTS=\\"-H tcp://0.0.0.0:4444 -H unix:///var/run/docker.sock\\"" > /etc/default/docker'
    sudo groupadd docker
    sudo gpasswd -a vagrant docker
    sudo restart docker
  SCRIPT
end