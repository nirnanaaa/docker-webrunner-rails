#!/bin/bash

PATH="/usr/bin:/bin:/usr/local/bin:/sbin:/usr/local/sbin:/usr/sbin"

case $1 in
  start)
    if [ ! -d /data ]; then
      if [ ! -z $2 ]; then
        git clone $2 /data
      else
        echo "No data directory and no GIT given in ARG2"
        exit 1
      fi
    fi
    export RAILS_ENV=production

    cd /data
    ruby /dpkg.rb
    bundle install --deployment --quiet
    [ -f /data/config/database.yml ] && bundle exec rake db:migrate
    bundle exec rake assets:precompile
    if [ -f /data/config/hooks/pre_start ]; then
      ruby /data/config/hooks/pre_start
    fi

    #/usr/local/bin/bundle exec puma -C /data/config/puma.rb -e production

    #bundle exec puma /data/config/puma.rb -e production



    supervisord -n
  ;;
  *)
    echo Commands:
    echo "    start       Launch the complete package"
  ;;
esac


wait
