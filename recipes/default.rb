# encoding: utf-8
#
# Cookbook Name:: sinopia
# Recipe:: default
#
# Copyright (C) 2014 Barthelemy Vessemont
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'sinopia::users'
include_recipe 'sinopia::nodejs'
include_recipe 'sinopia::sinopia'

# Don't do this
directory '/var/lib/foo' do
  owner 'root'
  group 'root'
  mode 644
  action :create
end
