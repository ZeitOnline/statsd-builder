# -*- mode: ruby -*- vi: set ft=ruby :

STATSD_VERSION = "0.7.2"


Vagrant.configure("2") do |config|
  config.vm.box_check_update = false

  config.berkshelf.enabled = true
  config.berkshelf.berksfile_path = "./Berksfile"

  config.ssh.forward_agent = true

  config.vm.define "default" do |default|
    # default.vm.provider "virtualbox"
    # default.vm.box = "ubuntu/trusty64"

    default.vm.provider "lxc"
    default.vm.box = "fgrehm/trusty64-lxc"

    default.vm.provision "shell", inline: "if [ ! -x /opt/chef/bin/chef-solo ]; then echo 'Downloading chef 12'; wget -q https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/10.04/x86_64/chef_12.2.1-1_amd64.deb && dpkg -i chef_12.2.1-1_amd64.deb ; else echo 'chef-solo already installed'; fi"

    default.vm.provision "chef_solo" do |chef|
      chef.install = false
      chef.log_level = ENV.fetch("CHEF_LOG", "info").downcase.to_sym

      chef.add_recipe "apt"
      chef.add_recipe "statsd"

      chef.json = {
        "statsd" => {
          "sha" => STATSD_VERSION,
          "package_version" => STATSD_VERSION,
        }
      }
    end

    default.vm.provision "shell", run: 'always', inline: "cp /tmp/statsd_#{STATSD_VERSION}_all.deb /vagrant"

    default.vm.hostname = "statsd-builder"
  end
end
