FROM ruby:2.3

RUN apt-get update

RUN apt-get install -y nginx nodejs

WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install --without test development

RUN mkdir -p /var/www/rails
WORKDIR /var/www/rails
ADD . /var/www/rails

RUN DEVISE_SECRET=temp RAILS_ENV=production bundle exec rake assets:precompile

ADD docker/nginx.conf /etc/nginx/nginx.conf
ADD docker/rails.conf /etc/nginx/sites-enabled/rails.conf
RUN rm /etc/nginx/sites-enabled/default

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/*

CMD bin/start.sh
