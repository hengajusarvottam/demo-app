#!/bin/sh

sleep 5
if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails s -b '0.0.0.0'