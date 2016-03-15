FROM ruby:2.3

RUN apt-get update

RUN apt-get install -y nginx nodejs

RUN mkdir -p /var/www/rails
WORKDIR /var/www/rails
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install --without test development

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/*