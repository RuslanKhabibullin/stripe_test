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
