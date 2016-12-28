FROM ruby:2.2.2-slim

RUN apt-get update -qq && apt-get install -y build-essential \
                                             libpq-dev \
                                             libsqlite3-dev \
                                             cron \
                                             nodejs && \
    apt-get clean -qq

RUN mkdir -p /docker
COPY ./bin/docker_entrypoint /docker/

RUN mkdir -p /bundle
ENV BUNDLE_PATH=/bundle

RUN mkdir -p /app
WORKDIR /app

RUN touch /var/log/whenever.log && chmod go+rw /var/log/whenever.log

EXPOSE 3000

ENTRYPOINT bin/docker_entrypoint $0 $@
