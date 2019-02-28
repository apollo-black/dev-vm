# Apollo Development VM

This Virtual Machine has everything installed that we use to develop software. It's the single source of runtime that imitates the production servers that we use.

## Usage

Steps:
1 Launch image with virtualbox
2. install git
3 clone repo
4. run set up

run: sudo mysql_secure_installation


1. Copy the `Vagrantfile` from this repository into your project root
2. Run `vagrant up`


## Dependencies

- [VirtualBox](https://www.virtualbox.org) `tested on v5.2.16`
- [Vagrant](https://www.vagrantup.com) `tested on v2.1.5`

## Installed Components

#### Programming Stacks

- [Nodejs 10.7.0](https://nodejs.org/en/)
- [NVM 0.33.11](https://github.com/creationix/nvm)
- [NPM 6.1.0](https://www.npmjs.com/)
- [PHP 7.0](http://php.net/)
- [Ruby 2.6.1](https://www.ruby-lang.org/en/)
- [Bundler 1.16.3](https://bundler.io/)
- [Webpacker 3.5.5](https://github.com/rails/webpacker)
- [Crystal 0.25.1](https://crystal-lang.org/)
- [Java 8](https://java.com/en/download/)
- [Python 2.7 & 3.5.2](https://www.python.org/)
- [Lua 5.3.5](https://www.lua.org/)

#### Databases

- [Postgres 10](https://www.postgresql.org/)
- [Redis 4.0.10](https://redis.io/)
- [Cassandra 3.11](http://cassandra.apache.org/)
- [MySQL 8.0](https://www.mysql.com/)

All database usernames and passwords would generally be:

- Username: vagrant
- Password: vagrant

## Machine Learning

- [Tensorflow 1.10](https://www.tensorflow.org)
- [Keras 2.2.2](https://keras.io)

#### Other Tools

- [AWS CLI Tools](https://aws.amazon.com/cli/)
- [Heroku Command Line v7.7.4](https://devcenter.heroku.com/articles/heroku-cli)
- [Docker]()
- [Vue CLI]()
- [React Native CLI]()
- [Yarn]()
- [Expo CLI]()
- [Tesseract]()

#### Utilities

There are utilities installed on the machine to help make life easier:

To share your environment using [ngrok](https://ngrok.com):

```
ngrok http 3000
```

[is-up 1.0](https://github.com/sindresorhus/is-up-cli): Check if a website is up or down.

```
is-up apollo.black
```

[pageres-cli 4.1.0](https://github.com/sindresorhus/pageres-cli): Capture screenshots of websites in any resolution

```
pageres apollo.black 1024x768
```

[loadtest 3.0.3](https://github.com/alexfernandez/loadtest): Perform a load test on any URL

```
loadtest -n 100 -c 5 -k apollo.black
```

[pgweb 0.9.12](https://github.com/sosedoff/pgweb): Plug and play Postgresql web interface

```
pgweb --host localhost --user app_user --db app_db
```

[htop](https://hisham.hm/htop/): Interactive unix process viewer

```
htop
```

[httpie](https://httpie.org/): Command line HTTP client

```
http -v apollo.black
```

## Useful Vagrant Commands

Daily use sometimes requires that you destroy or reload virtual machines, here are some useful commands.

##### Launch a VM
```
vagrant up
```

##### Connect to VM via SSH
```
vagrant ssh
```

##### Stop a VM
```
vagrant halt
```

##### Reload a VM without needing to destroy it
```
vagrant reload
```

##### Destroy a VM
```
vagrant destroy
```

##### Show VM's & Statuses
```
vagrant global-status
```

## Environment Variables

To make life easier, we have the following ENV variables defined in `/etc/environment`:

```
> DATABASE_URL="postgresql://vagrant:vagrant@127.0.0.1:5432/vagrant"
> REDIS_URL="redis://localhost:6379"
> RAILS_ENV="development"
```

You can add new ENV vars to either the `/etc/environment` file or the `~/.profile` file.

If you install [Nginx](https://www.nginx.com/) and [Phusion Passenger](https://www.phusionpassenger.com/) on the VM and want to set application specific `ENV` variables, you can use [passenger_env_var](https://www.phusionpassenger.com/library/config/nginx/reference/#passenger_env_var) directive:

```
> passenger_env_var DATABASE_URL postgresql://vagrant:vagrant@127.0.0.1:5432/vagrant;
> passenger_env_var REDIS_URL redis://localhost:6379;
```
Similarly, with [Apache2](https://httpd.apache.org/), you can use the [SetEnv](https://httpd.apache.org/docs/2.4/mod/mod_env.html) directive:

```
> SetEnv DATABASE_URL postgresql://vagrant:vagrant@127.0.0.1:5432/vagrant
> SetEnv REDIS_URL redis://localhost:6379
```

## Memory / VRAM

You can adjust the available VM memory within the `Vagrantfile`, by changing `vb.memory`:

```
config.vm.provider "virtualbox" do |vb|
  vb.memory = "2048"
end
```

Any number not exceeding your available host RAM will work.

**Note:** Depending on what development frameworks you want to use, you'll need to fiddle with the available VRAM for your VM instance. Java and .Net(Mono), BigData or ML/AI based projects will require much more VRAM than simpler tech like PHP or Ruby.

## License

MIT License

Copyright (c) 2019 Apollo Black

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
