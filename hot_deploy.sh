#!/bin/bash
set -e

if [[ ! -d /vagrant ]]; then
  echo "ERROR: Only run this script inside the vagrant machine"
  exit 1
fi

: ${1:?"Need version to upgrade to: e.g. ${0} 0.1.1"}
UPGRADE_VERSION=${1}

# Do a hot deploy of version ${UPGRADE_VERSION}
echo "### Upgrading the demo application ###"
if [[ ! -d "/opt/demo_web/releases/${UPGRADE_VERSION}" ]]; then
  mkdir /opt/demo_web/releases/${UPGRADE_VERSION}
  cp /vagrant/_build/prod/rel/hot_deploy_demo/releases/${UPGRADE_VERSION}/hot_deploy_demo.tar.gz /opt/demo_web/releases/${UPGRADE_VERSION}/
fi

# Perform the upgrade
PORT=7000 /opt/demo_web/bin/hot_deploy_demo upgrade ${UPGRADE_VERSION}
