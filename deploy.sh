#!/bin/bash
set -e

if [[ ! -d /vagrant ]]; then
  echo "ERROR: Only run this script inside the vagrant machine"
  exit 1
fi

# Elixir needs UTF-8
sudo locale-gen en_AU.UTF-8

# Deploy the release tarball to the right location
echo "### Deploying the demo application. ###"
sudo mkdir -p /opt/demo_web
sudo chown ${USER}:${USER} /opt/demo_web
tar -C /opt/demo_web -xf /vagrant/_build/prod/rel/hot_deploy_demo/releases/0.1.0/hot_deploy_demo.tar.gz

# Start the application
echo "### Starting the demo application. ###"
PORT=7000 /opt/demo_web/bin/hot_deploy_demo start
