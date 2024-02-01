# Use Ruby image based on Alpine
FROM ruby:3.2-alpine

# Install build dependencies for native extensions
# and PostgreSQL client (for 'pg' gem)
RUN apk add --no-cache build-base postgresql-dev

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile* ./

# Install gems, excluding development and test groups
RUN bundle config set without 'development test' && bundle install

# Copy the main application
COPY . .

# Expose port 9292 to the outside world
EXPOSE 9292

# Define the command to start the server
CMD ["rackup", "--host", "0.0.0.0", "-p", "9292"]
