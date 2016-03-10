# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.
  
  # Give your virtual machine a snappy name to remember
  config.vm.hostname = "omeka"

  # what version of Linux do you want to run?
  # Search here: https://atlas.hashicorp.com/boxes/search
  config.vm.box = "ubuntu/trusty64"


  # Are you installing something runs on the web? If so,
  # what ports does it run on? You can use these to make your application
  # accessible to the outside world <-- a key power of vagrant
  config.vm.network :forwarded_port, guest: 80, host: 80

  # Let's set some computer specs
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 1024
    vb.cpus = 1
  end

  # Do you have stuff in your current folder that you want the application to easily get to?
  shared_dir = "/vagrant"

  # These lines below run scripts that you or other make. These setup the machine and install software
  # The lines above would give you a basic machine with little software (which is great in and of itself)
  # If you want certain software installed, below is where you do it.
  config.vm.provision "shell", path: "omeka.sh", args: shared_dir

end