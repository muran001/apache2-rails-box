# apache2-rails-box

## Introduction 

This project automates the setup of a development environment for Ruby on Rails.

It consists of 
- apache2 (passenger)
- rails (ruby2.1.1)
- mysql
- jenkins


## Supported Platforms

Supported Platforms are below.

- ubuntu12.04

## Requirements

- opscode-cookbooks
-- apt
-- build-essential
-- apache2
-- git
-- vim
-- mysql
-- database
-- rbenv
-- ruby_build
-- timezone
-- jenkins


## Usage


```
# first of all
$ vagrant up

# if you want to provision only
$ vagrant provision
```


