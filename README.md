puppet
===

For this class we require the Vagrant + VirtualBox VM setup as it comes most prepared to be set up with Puppet.

### Setup

1. [Download and install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
1. [Download and install Vagrant](https://www.vagrantup.com/downloads.html)

Next, download this repository, either by:

1. Git clone
1. Downloading ZIP and unpacking

Then, once those are installed, simply change directories in your terminal until you are in the directory which contains `Vagrantfile`. 

From the terminal, launch the VM with:

	$ vagrant up client # may take a few minutes the first time, it has to download the image

Once that is complete, you can ssh into your VM instance:

	$ vagrant ssh client
	[vagrant@client]$

You should be able to run:

	[vagrant@client]$ puppet --version
	4.4.0
	[vagrant@client]$ sudo puppet --version
	4.4.0

and you're ready to go!
