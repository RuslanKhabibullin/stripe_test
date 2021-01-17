[![Codeship Status for RuslanKhabibullin/stripe_test](https://app.codeship.com/projects/29a94b77-daf8-40f0-aff4-ac486ab9b2c8/status?branch=master)](https://app.codeship.com/projects/424195)

# Stripe pet project

Pet project with a charge through Stripe system.

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
