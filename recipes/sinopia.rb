# encoding: utf-8
#
# Cookbook Name:: sinopia
# Recipe:: sinopia
#

require 'digest'

package 'gcc'
package 'make'
package 'build-essential'

node_npm 'sinopia' do
  version node['sinopia']['version']
  action :install
end

directory node['sinopia']['confdir'] do
  recursive true
end

directory node['sinopia']['logdir'] do
  owner node['sinopia']['user']
  group node['sinopia']['user']
end

directory node['sinopia']['datadir'] do
  owner node['sinopia']['user']
  group node['sinopia']['user']
end

admin_add_list = []

node['sinopia']['users'].each do |user, conf|
  admin_add_list.push(user) if conf['admin']
end

template File.join(node['sinopia']['confdir'], 'config.yaml') do
  source 'config.yaml.erb'
  variables(
    :admins => admin_add_list
  )
  notifies :restart, 'service[sinopia]', :delayed
end

logrotate_app 'sinopia' do
  cookbook 'logrotate'
  path File.join(node['sinopia']['logdir'], 'sinopia.log')
  frequency 'daily'
  rotate node['sinopia']['logdays']
  create '644 root adm'
end

template '/etc/init/sinopia.conf' do
  source 'sinopia.conf.erb'
end

service 'sinopia' do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :reload => false
  action [:enable, :start]
end
