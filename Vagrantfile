# vagrant up
# vagrant vagrant rsync-auto

VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'chef/centos-6.5'
  config.vm.boot_timeout = 300
  config.vm.network :forwarded_port, :guest => 8080, :host => 8080
  config.vm.provider :vmware_workstation do |v|
    v.gui = true
    v.vmx["memsize"]    = '1024'
    v.vmx["numvcpus"]   = '4'
    v.vmx["vhv.enable"] = 'True'
  end
  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', '1024']
    vb.customize ['modifyvm', :id, '--natdnsproxy1', 'off']
    vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'off']
    vb.customize ['modifyvm', :id, '--cpus', '2']
    vb.customize ['modifyvm', :id, '--ioapic', 'on']
  end
  config.berkshelf.enabled = true
  config.berkshelf.berksfile_path = './Berksfile'
  config.vm.provision :chef_solo do |chef|
    chef.run_list = %w(dev::vagrant dev::default dev::movabletype dev::mailmug)
    chef.json = {
        :mysql => {
            :server_root_password => '',
        },
    }
  end
  config.omnibus.chef_version = '11.16.4'
  config.ssh.forward_agent = true
  config.vm.synced_folder './mt', '/var/www/cgi-bin/mt'
  config.vm.synced_folder './plugins/MailMug', '/var/www/cgi-bin/mt/plugins/MailMug'
  config.vm.synced_folder './mt-static/plugins/MailMug', '/var/www/html/mt-static/plugins/MailMug'
end
