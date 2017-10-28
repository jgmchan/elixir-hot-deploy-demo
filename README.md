# Elixir Hot deploy demo

This is a simple demo project to show Elixir hot deployments.

It contains:
* A Simple Phoenix application with a websocket that just increments
  a counter and broadcasts it to some topics.
* A script that changes the source project and builds a few releases used
  for demoing hot upgrades.

  * `0.1.0` - The first version of the application
  * `0.1.1` - `DemoWeb.Feed` increments by 100 instead of 1
  * `0.1.2` - `DemoWeb.FeedWithGenServer` increments by 100 instead of 1
  * `0.1.3` - Intercept the `FEED` messages and add `foo: "bar"` to message

# Dependencies

* Docker (To build the releases)
* Vagrant (For a VM to run the released application)

# Instructions

1. `./build_all_versions.sh` to build all the different versioned tarballs
