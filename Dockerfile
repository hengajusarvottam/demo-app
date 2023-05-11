FROM ruby:3.0.2
# Need to map /rails-docker in docker-compose.yml to map in volume
ENV APP_HOME /rails-docker
# Create a directory for our application
# and set it as the working directory
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
# Installation of dependencies
RUN apt-get update -qq \
  && apt-get install -y \
      # Needed for certain gems
    build-essential \
         # Needed for postgres gem
    libpq-dev \
    # The following are used to trim down the size of the image by removing unneeded data
  && apt-get clean autoclean \
  && apt-get autoremove -y \
  && rm -rf \
    /var/lib/apt \
    /var/lib/dpkg \
    /var/lib/cache \
    /var/lib/log

# Add our Gemfile and install gems
ADD Gemfile* $APP_HOME/
RUN bundle install
# Copy over our application code
ADD . $APP_HOME
EXPOSE 5000

# Start the main process.
# Run our app
# CMD sh -c "/bin/sh start.sh"
CMD sh -c 'if [ -f tmp/pids/server.pid ]; then rm tmp/pids/server.pid; fi; \
  bundle exec rails db:create; \
  bundle exec rails db:migrate; \
  bundle exec rails s -b "0.0.0.0"'