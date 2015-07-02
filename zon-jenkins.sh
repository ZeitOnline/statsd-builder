#!/bin/sh

set -e

vagrant up

vagrant ssh -c "find /vagrant -name 'statsd*.deb'" -- -q | while read packageName; do
    sudo aptly repo add zeit $packageName
done
sudo aptly publish update zeit

vagrant halt

