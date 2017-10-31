# Elixir Hot deploy demo

This is a simple demo project to show Elixir hot deployments with [Distillery](https://github.com/bitwalker/distillery).

It contains:
* A Simple Phoenix application with:
  * `DemoWeb.Web.RoomChannel` - A channel to connect to via websockets
  * `DemoWeb.Feed` - A simple loop which increments a counter and broadcasts it
     to `room:feed` channel
  * `DemoWeb.FeedWithGenServer` - Does the same thing as `DemoWeb.Feed` but
     implemented with a `GenServer` and broadcasts to `room:feed_gen`

* `build_all_versions.sh` that changes the source project and builds a few releases used
  for demoing hot upgrades.

  * `0.1.0` - The first version of the application
  * `0.1.1` - `DemoWeb.Feed` increments by 100 instead of 1
  * `0.1.2` - `DemoWeb.FeedWithGenServer` increments by 100 instead of 1
  * `0.1.3` - Intercept the `FEED` messages and add `foo: "bar"` to message

* `deploy.sh` - Deploys the initial release inside a vagrant machine
* `hot_deploy.sh` - Hot deploys the upgrade releases inside a vagrant machine

# Dependencies

* Docker (To build the releases)
* Vagrant (For a VM to run the released application)
* [ws](https://github.com/hashrocket/ws) (Or whatever websocket client you like)

# Instructions

1. Build the release and all the upgrade versions
   ```
   ./build_all_versions.sh
   ```
2. Start up the vagrant machine and log in
   ```
   vagrant up && vagrant ssh
   ```
3. Deploy the release inside the vagrant machine
   ```
   /vagrant/deploy.sh
   ```
4. Hot upgrade/downgrade to a different version, e.g.
   ```
   /vagrant/hot_deploy.sh 0.1.1
   ```

# Connect to websocket
```
ws ws://localhost:7000/socket/websocket
> {"topic":"room:feed","event":"phx_join","payload":{},"ref":1}
> {"topic":"room:feed_gen","event":"phx_join","payload":{},"ref":1}
``````
