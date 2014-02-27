# encoding: utf-8
#
# Cookbook Name:: sinopia
# Recipe:: nodejs
#

package 'make'

include_recipe 'nodejs'
include_recipe 'nodejs::npm'
