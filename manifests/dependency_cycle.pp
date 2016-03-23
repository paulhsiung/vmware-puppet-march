###########################################################################
#
# $ puppet apply /vagrant/manifests/depcycle.pp --graph  # to graph it
# then go here: http://www.webgraphviz.com/  # to visualize
#
###########################################################################

file { '/tmp/file-exists.txt':
  ensure  => file,
  require => Cron['check-exists'],
}
cron { 'check-exists':
  user    => 'vagrant',
  command => 'cat /tmp/file-exists.txt',
  minute  => '*/5',
  require => File['/tmp/file-exists.txt'],
}