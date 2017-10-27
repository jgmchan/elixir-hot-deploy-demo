FROM ubuntu:xenial

ENV LANG=C.UTF-8

RUN apt-get update

RUN apt-get install -y curl && \
    curl -O https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && dpkg -i erlang-solutions_1.0_all.deb

RUN apt-get update && apt-get install -y esl-erlang elixir git

RUN mix local.hex --force && mix local.rebar --force
