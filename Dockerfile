FROM ruby:2.6.6-slim-buster

RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
    build-essential \
    curl \
    git \
    gnupg2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Add PostgreSQL to sources list
ARG PG_MAJOR
RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && echo 'deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main' $PG_MAJOR > /etc/apt/sources.list.d/pgdg.list


# Add NodeJS to sources list
ARG NODE_MAJOR
RUN curl -sL https://deb.nodesource.com/setup_$NODE_MAJOR.x | bash -


# Add Yarn to the sources list
ARG YARN_VERSION
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list


# Install Dependencies
RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
    libpq-dev \
    postgresql-client-$PG_MAJOR \
    nodejs \
    yarn=$YARN_VERSION-1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN rm -f .bundle/config
RUN gem install bundler -v 1.17.3

RUN mkdir /app
WORKDIR /app
