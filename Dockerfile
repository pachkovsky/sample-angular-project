FROM 598396839027.dkr.ecr.us-east-1.amazonaws.com/sap:base-image

ADD . /var/www/rails

RUN bundle install --without test development

RUN DEVISE_SECRET=temp RAILS_ENV=production bundle exec rake assets:precompile

ADD docker/nginx.conf /etc/nginx/nginx.conf
ADD docker/rails.conf /etc/nginx/sites-enabled/rails.conf
RUN rm /etc/nginx/sites-enabled/default

CMD bin/start.sh