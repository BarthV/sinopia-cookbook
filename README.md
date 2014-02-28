# sinopia cookbook
[![Build Status](https://travis-ci.org/BarthV/sinopia-cookbook.png?branch=master)](https://travis-ci.org/BarthV/sinopia-cookbook)

Sinopia project : https://github.com/rlidwka/sinopia/

Sinopia is a private/caching npm repository server.

It allows you to have a local npm registry with zero configuration. You don't have to install and replicate an entire CouchDB database. Sinopia keeps its own small database and, if a package doesn't exist there, it asks npmjs.org for it keeping only those packages you use.

# Requirements

- Chef >= 11
- Currently only tested with chef 11.10 on Ubuntu 12.04.
- Sinopia Cookbook heavily depends on `nodejs` and `node` community cookbooks.

# Usage

Add `recipe[sinopia]` to the node runlist.

Default recipe with no other options will :

- Configure sinopia folders (in /etc, /var & /var/log)
- Install node + npm from the official repo at the latest version
- Create a passwordless sinopia user who will run the service
- Install latest version of sinopia from npmjs.org
- Configure log rotation to 30d
- Setup and start sinopia service (based on upstart for now)

## Defaults
* Sinopia will bind to `127.0.0.1:4873`, so you probably need to setup a web frontend.
* Access to the npm service is allowed to everyone.
* All desired packages are cached from https://registry.npmjs.org/
* A single npm account is provisionned to publish private packages with :
 * login : `admin`
  * passw : `admin`

# Attributes
Every single Sinopia configuration item can be managed from node attributes.
Default values are specified each time.

## System configuration

`node['sinopia']['user']` : (sinopia) default user running sinopia

`node['sinopia']['confdir']` : (/etc/sinopia) config.yaml file location

`node['sinopia']['datadir']` : (/var/lib/sinopia) Sinopia cache & private stores location

`node['sinopia']['logdir']` : (/var/log/sinopia) sinopia.log file location

`node['sinopia']['logdays']` : (30) log retention policy, `Integer` days 

## Sinopia global conf

`node['sinopia']['version']` : (nil) Synopia npm package version, use `nil` for latest

`node['sinopia']['admin']['pass']` : (admin) Synopia admin account clear password

`node['sinopia']['public_url']` : Sinopia rewrite url, url prefix for provided links 

`node['sinopia']['timeout']` : (nil) Sinopia timeout, software default is 30000 ms 
`node['sinopia']['maxage']` : (nil) Sinopia metadata cache max age, software defaut is
`node['sinopia']['max_body_size']` : (nil)


## Users and rights

No users are created by default.

* You can set user list with a hash under `default['sinopia']['users']`, you need to specify a password for each user
* You can give admin right to a specific user with `user['admin'] = true` hash

Example: 
   node['sinopia']['users']['bob']['pass'] = 'incredible'
   node['sinopia']['users']['bob']['admin'] = true
   
   node['sinopia']['users']['andy']['pass'] = 'toys'
   node['sinopia']['users']['andy']['admin'] = true
   
   node['sinopia']['users']['woody']['pass'] = 'buzzl'

## NPM Registry

You can store a list of available npm repositories in `node['sinopia']['repos']` following 'name' => 'url' syntax. 

Default hash is loaded with official npmjs repo : `default['sinopia']['repos'] = {'npmjs' => 'https://registry.npmjs.org/'}`

Example :
   node['sinopia']['repos'] = {
     'npmjs' => 'https://registry.npmjs.org/', # official npmjs repo
     'myrepo' => 'https://myrepo.local/',
     'other' => 'https://third-party-repo.com'
   }

`node['sinopia']['mainrepo']` : (npmjs) Caching repository selected from available repos list

# Recipes

# Author

Author:: Barthelemy Vessemont (<bvessemont@gmail.com>)
