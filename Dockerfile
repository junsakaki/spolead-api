FROM ruby:2.6.5
ENV LANG C.UTF-8

# install required libraries
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs && \
    apt-get install -y nginx




# Nginx
ADD nginx.conf /etc/nginx/sites-available/app.conf
RUN rm -f /etc/nginx/sites-enabled/default && \
    ln -s /etc/nginx/sites-available/app.conf /etc/nginx/sites-enabled/app.conf


RUN gem install bundler -v 2.0.2

# install bundler
RUN gem install bundler

# WORKDIR /tmp
# ADD Gemfile Gemfile
# ADD Gemfile.lock Gemfile.lock
# RUN bundle install

RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install
ADD . /app
RUN mkdir /app/tmp/sockets

CMD bundle exec puma -d && \
    /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
