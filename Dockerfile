FROM ubuntu:latest
MAINTAINER Florian Kasper <mosny@zyg.li>

# VMAIL
RUN groupadd --gid 10000 web
RUN useradd --gid 10000 --uid 10000 web

RUN apt-get update -yqq
RUN apt-get upgrade -yqq

# Install packages
RUN apt-get install -yqq supervisor ruby ruby-dev git-core automake build-essential
RUN gem install bundler

ADD add_dpkg.rb /dpkg.rb
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 9393

ADD start.sh /start.sh
entrypoint ["/start.sh"]
