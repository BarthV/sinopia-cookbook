# encoding: utf-8

## System user running sinopia
default['sinopia']['user'] = 'sinopia'

## sinopia gem version (use nil for latest)
default['sinopia']['version'] = nil

## sinopia users configuration
default['sinopia']['admin']['pass'] = 'admin'

default['sinopia']['users'] = {}
# default['sinopia']['users']['barth']['pass'] = 'azerty'
# default['sinopia']['users']['barth']['admin'] = true
# default['sinopia']['users']['andy']['pass'] = 'password'
# default['sinopia']['users']['andy']['admin'] = true
# default['sinopia']['users']['woody']['pass'] = 'buzz'

## sinopia links rewrite URL (url_prefix)
# default['sinopia']['public_url'] = 'https://my-npm-private-repo.local/'

## Bind address (IP:port format)
# use ':port' or '0.0.0.0:port' to listen on all interfaces
default['sinopia']['listen'] = nil # 127.0.0.1:4873

## sinopia conf directories
# Parents directory MUST exists !
default['sinopia']['confdir'] = '/etc/sinopia'
default['sinopia']['logdir'] = '/var/log/sinopia'
default['sinopia']['datadir'] = '/var/lib/sinopia'

## NodeJS repo list options
default['sinopia']['repos'] = {
  'npmjs' => 'https://registry.npmjs.org/',
  'norepo' => 'https://dev.null/'
}

default['sinopia']['mainrepo'] = 'npmjs' 

default['sinopia']['timeout'] = nil # 30000 ms
default['sinopia']['maxage'] = nil # 120 s
default['sinopia']['max_body_size'] = nil # 1mb

default['sinopia']['use_proxy'] = false
default['sinopia']['proxy']['http'] = 'http://something.local/'
default['sinopia']['proxy']['https'] = 'https://something.local/'
default['sinopia']['proxy']['no_proxy'] = [
  'localhost', '127.0.0.1'
]

## local repos ACL - filters
default['sinopia']['filters'] = [
#  {
#    'name' => 'private-*',
#    'storage' => 'private-repo'
#  },
#  {
#    'name' => 'admin-*',
#    'access' => ['andy', 'woody']
#  },
#  {
#    'name' => 'test-*',
#    'access' => '@admins'
#  }
]

## Logging options
# type: file | stdout | stderr
# level: trace | debug | info | http (default) | warn | error | fatal
#
# parameters for file: name is filename
#  {type: 'file', path: 'sinopia.log', level: 'debug'},
#
# parameters for stdout and stderr: format: json | pretty
#  {type: 'stdout', format: 'pretty', level: 'debug'},
default['sinopia']['logs'] = [
  "{type: file, path: #{File.join(node['sinopia']['logdir'], 'sinopia.log')}, level: http}"
]

## Node default install method (source | package | binary)
default['nodejs']['install_method'] = 'package'

## Node target default version (set nil to use latest version from repo)
case node['nodejs']['install_method']
when 'package'
  default['nodejs']['version'] = nil
else
  default['nodejs']['version'] = '0.10.26' # 2014.02.18 (Stable)
end

## NPM target version (set nil to use nodejs embedded npm)
default['nodejs']['npm'] = nil
