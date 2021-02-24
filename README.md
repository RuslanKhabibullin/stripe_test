[![Build Status](https://ruslankhabibullin.semaphoreci.com/badges/stripe_test/branches/master.svg)](https://ruslankhabibullin.semaphoreci.com/projects/stripe_test)

# Stripe pet project

Pet project with a charge through Stripe system.

Heroku url: https://stripe-pet-project.herokuapp.com/

## Setup

How to run tests:

```
bin/rspec spec
```

How to run development console:

```
bin/rails c
```

How to run server:

```
bin/server
```

How to run quality checks:

```
bin/quality
```

Setup script:

```
bin/setup
```

Stripe local development setup (webhooks):

```
stripe listen --forward-to localhost:5000/stripe/webhook
```

## Setup using Docker

- Run `docker-compose build` to build app images


Before continuing:
- Need to free `5432` port - please stop local `postgres` service if present
- Need to free `6379` port - please stop local `redis` service if present
- Need to free `9200` and `9300` ports - please stop local `elastic` service if present

Install project dependencies:

- Run `docker-compose run --rm web bundle install -j4 --retry 3` - install gems
- Run `docker-compose run --rm web yarn install` - install node modules
