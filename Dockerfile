FROM ruby:2.7
RUN apt-get update -qq && apt-get install -y build-essential nodejs
RUN mkdir /crowler_quotes
WORKDIR /crowler_quotes
COPY Gemfile /crowler_quotes/Gemfile
COPY Gemfile.lock /crowler_quotes/Gemfile.lock
RUN bundle install
COPY . /crowler_quotes

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]