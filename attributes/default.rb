# encoding: utf-8

## System user running sinopia
default['sinopia']['user'] = 'sinopia'

## sinopia gem version (use nil for latest)
default['sinopia']['version'] = nil

## sinopia users configuration
default['sinopia']['admin']['password'] = 'admin'

default['sinopia']['users']['andy']['password'] = 'andy'
default['sinopia']['users']['andy']['admin'] = true
default['sinopia']['users']['woody']['password'] = 'woody'

## sinopia conf directories
# Parents directory MUST exists !
default['sinopia']['confdir'] = '/etc/sinopia'
default['sinopia']['logdir'] = '/var/log/sinopia'
default['sinopia']['cachedir'] = '/var/lib/sinopia'

## NodeJS repo list options
default['sinopia']['repos'] = {
  'npmjs' => 'https://registry.npmjs.org/',
  'toto' => 'https://dev.null/'
}

default['sinopia']['conf']['two'] = ''

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
