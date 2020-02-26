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
* Erlang or [Elixir](https://elixir-lang.org/install.html#distributions) (required *ONLY* if you want to connect a local instance to the demo server for observability, otherwise just ignore)

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
You can connect to the topic with `ws` and see the counter incrementing with the following commands:
```
ws ws://localhost:7000/socket/websocket
> {"topic":"room:feed","event":"phx_join","payload":{},"ref":1}
> {"topic":"room:feed_gen","event":"phx_join","payload":{},"ref":1}
```

# Observing the demo server inside the VM
You can spin up a local erlang node and join with the demo server inside vagrant to form a cluster.
Once connected you can use `:observer` to start up an observer session to look at all the internal
information for the demo server.

See https://gist.github.com/pnc/9e957e17d4f9c6c81294 for more details

1. Set up some port forwards from your vagrant machine so your local
   instance can talk to the instance inside the VM.

    ```
    vagrant ssh -- -L9000:localhost:9000 -L4369:localhost:4369
    ```

    Port 4369 is the EPMD port (See https://erlang.org/doc/man/epmd.html for more details)
    Port 9000 is the port the erlang VM inside vagrant will be listening for other nodes to connect

2. Spin up a local erlang instance which will then start up an observer

    ```
    erl -name debug@127.0.0.1 -setcookie 'super-secret-cookie' -hidden -run observer
    ```

3. To look at the stats and process for the demo server, click `Nodes` and then `hot_deploy_demo@127.0.0.1`.
   The observer should now show the metrics and process for the demo server.

# Demos

## Upgrading to version 0.1.1 (Old)
[![asciicast](https://asciinema.org/a/0npddfmYVcPYR8N52ADmuCrKM.png)](https://asciinema.org/a/0npddfmYVcPYR8N52ADmuCrKM)

## Upgrading to version 0.1.2 (Old)
[![asciicast](https://asciinema.org/a/AzycbEQbF0tmFvbrz2sGWqzdh.png)](https://asciinema.org/a/AzycbEQbF0tmFvbrz2sGWqzdh)

## Upgrading to version 0.1.3 (Old)
[![asciicast](https://asciinema.org/a/6wP3YQM8JEA23wTezNyNR6tup.png)](https://asciinema.org/a/6wP3YQM8JEA23wTezNyNR6tup)
