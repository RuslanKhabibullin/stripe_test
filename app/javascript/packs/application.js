import { loadStripe } from '@stripe/stripe-js'

require('jquery')
require('@rails/ujs').start()

window.App = {}

App.stripePromise = loadStripe(process.env.STRIPE_PUBLIC_KEY)
