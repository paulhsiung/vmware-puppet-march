# -*- mode: ruby -*-

##################################################################################
# Much of the credit for this Vagrantfile and examples goes to Joe Rhett 
# in Learning Puppet 4:
# http://shop.oreilly.com/product/0636920034131.do
#
# It's a fantastic resource, and I can't recommend purchasing it highly enough.
##################################################################################

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
Vagrant.require_version ">= 1.5.2"

$setupscript = <<END
  # Lock down domain name
  echo 'supercede domain-name "example.com";' > /etc/dhcp/dhclient.conf

  # Our version of /etc/hosts for Vagrant setup
  echo "-> Writing to /etc/hosts"
  cp /vagrant/files/misc/hosts /etc/hosts

  # Allow us to apply with puppet without using sudo
  echo "-> Adding to sudoers file"
  sed -i -e 's#\(secure_path = .*\)$#\1:/opt/puppetlabs/bin#' /etc/sudoers

  # share codedir
  echo "-> Sharing codedir"
  mkdir -p /home/vagrant/.puppetlabs/etc/puppet
  cp /vagrant/files/agent/user-puppet.conf /home/vagrant/.puppetlabs/etc/puppet/puppet.conf
  echo "-> Chown /home/vagrant/.puppetlabs"
  chown -R vagrant:vagrant /home/vagrant/.puppetlabs

  # install hiera settings
  echo "-> Install hiera settings"
  mkdir -p /etc/puppetlabs/puppet
  cp /vagrant/files/puppet.conf /etc/puppetlabs/puppet/

  echo "-> Ensure code directory"
  mkdir -p /etc/puppetlabs/code

  echo "-> Chown /etc/puppetlabs"
  sudo chown -R vagrant:vagrant /etc/puppetlabs
  sudo grep secure_path /etc/sudoers | sed -e 's#$#:/opt/puppetlabs/bin#' | sudo tee /etc/sudoers.d/puppet-securepath

  # banner message
  echo "
Welcome to Puppet!
" > /etc/motd
  # Enable MotD
  sed -i -e 's/^PrintMotd no/PrintMotd yes/' /etc/ssh/sshd_config
  systemctl reload sshd
END

$client_setupscript = <<END
sudo yum install -y http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
sudo yum install -y puppet nano bind-utils

echo "-> Chowning again /etc/puppetlabs"
sudo chown -R vagrant:vagrant /etc/puppetlabs
END

$server_setupscript = <<END
sudo yum install -y http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
sudo yum install -y puppetserver puppet nano bind-utils

echo "-> Chowning again /etc/puppetlabs"
sudo chown -R vagrant:vagrant /etc/puppetlabs
END

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "puppetlabs/centos-7.0-64-nocm"
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
  end

  # clients
  config.vm.define "client", primary: true do |client|
    client.vm.hostname = "client.example.com"
    client.vm.network :private_network, ip: "192.168.250.10"
    client.vm.provision "shell", inline: $setupscript
    client.vm.provision "shell", inline: $client_setupscript
  end

  # Puppet Server
  # config.vm.define "puppetserver", autostart: false do |puppetserver|
  #   puppetserver.vm.hostname = "puppet-server.example.com"
  #   puppetserver.vm.network :private_network, ip: "192.168.250.6"
  #   puppetserver.vm.provision "shell", inline: $setupscript
  #   puppetserver.vm.provision "shell", inline: $server_setupscript
  #   puppetserver.vm.provider :virtualbox do |ps|
  #     ps.memory = 2048
  #   end
  # end

  # # Puppet Dashboard
  # config.vm.define "dashboard", autostart: false do |puppetserver|
  #   puppetserver.vm.hostname = "dashserver.example.com"
  #   puppetserver.vm.network :private_network, ip: "192.168.250.7"
  #   puppetserver.vm.provision "shell", inline: $setupscript
  #   puppetserver.vm.provider :virtualbox do |ps|
  #     ps.memory = 1024
  #   end
  # end
  
end
