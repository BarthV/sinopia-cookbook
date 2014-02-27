# encoding: utf-8
#
# Cookbook Name:: sinopia
# Recipe:: sinopia
#

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

directory node['sinopia']['cachedir'] do
  owner node['sinopia']['user']
  group node['sinopia']['user']
end

admin_list = ''

node['sinopia']['users'].each do |user,conf|
  if conf['admin']
    admin_list += ' ' + user
  end
end

template File.join(node['sinopia']['confdir'], 'config.yaml') do
  source 'config.yaml.erb'
  variables(
    :admins => admin_list
  )
end

# template '/etc/init/npmlazy.conf' do
#   source 'npmlazy.conf.erb'
# end

# service 'npmlazy' do
#   provider Chef::Provider::Service::Upstart
#   supports :status => true, :restart => true, :reload => false
#   action [:enable, :start]
# end
