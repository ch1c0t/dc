# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure '2' do |config|
  config.vm.box = 'ailispaw/barge'
  config.vm.synced_folder '.', '/vagrant'

  config.vm.provision :docker, run: :always,
    images: [
      'ruby:alpine',
      'redis:alpine',
      'nginx:alpine',
    ]

  config.vm.network :forwarded_port,
    guest: 2375, host: 2375, host_ip: '127.0.0.1'
  config.vm.network :forwarded_port,
    guest: 6379, host: 6379, host_ip: '127.0.0.1'
  config.vm.network :forwarded_port,
    guest: 8080, host: 8080, host_ip: '127.0.0.1'
end
