FROM gusto/ruby:3.1.2-ubuntu20.04-fullstaq-jemalloc

RUN apt-get update -qq && apt-get install -y build-essential libyaml-dev

# installing tzdata
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
RUN apt-get install -y tzdata

WORKDIR /tanam-ya-backend
COPY Gemfile /tanam-ya-backend/Gemfile
COPY Gemfile.lock /tanam-ya-backend/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts
COPY entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
