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

directory node['sinopia']['conf']['confdir'] do
  recursive true
end

directory node['sinopia']['conf']['logdir'] do
  owner node['sinopia']['user']
  group node['sinopia']['user']
end

directory node['sinopia']['conf']['cachedir'] do
  owner node['sinopia']['user']
  group node['sinopia']['user']
end

# template File.join(node['npmlazy']['conf']['confdir'], 'npm_lazy_config.js') do
#   source 'npm_lazy_config.js.erb'
# end

# template '/etc/init/npmlazy.conf' do
#   source 'npmlazy.conf.erb'
# end

# service 'npmlazy' do
#   provider Chef::Provider::Service::Upstart
#   supports :status => true, :restart => true, :reload => false
#   action [:enable, :start]
# end
