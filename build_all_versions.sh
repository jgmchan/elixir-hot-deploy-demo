#!/bin/bash
set -xe

find . -name '*.orig' -exec rm {} \;
find . -name '*.rej' -exec rm {} \;

# Make initial release (0.1.0)
make release

# Patch and make hotupgrade release 0.1.1
patch -p1 < patches/0.1.1_feed.patch
make release_upgrade

# Patch and make hotupgrade release 0.1.2
patch -p1 < patches/0.1.2_feed_gen.patch
make release_upgrade

# Patch and make hotupgrade release 0.1.3
patch -p1 < patches/0.1.3_channel.patch
make release_upgrade
