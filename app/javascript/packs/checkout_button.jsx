import React, { useState } from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

const CHECKOUT_PATH = '/items/:id/payments'

const CheckoutButton = ({ id, csrfToken }) => {
  const [buttonEnabled, setButtonEnabled] = useState(true)
  const handlePurchaseClick = async (_event) => {
    setButtonEnabled(!buttonEnabled)
    const stripe = await window.App.stripePromise
    const response = await fetch(
      CHECKOUT_PATH.replace(':id', id),
      { method: 'POST', headers: { 'X-CSRF-TOKEN': csrfToken } }
    )
    const session = await response.json()
    await stripe.redirectToCheckout({ sessionId: session.id })
  }

  return (
    <section className='item-checkout' id={`item-checkout-${id}`}>
      <button
        id='checkout-button'
        className='button item-checkout__button'
        role='link'
        onClick={handlePurchaseClick}
        disabled={!buttonEnabled}
      >
        Checkout
      </button>
    </section>
  )
}

CheckoutButton.propTypes = {
  id: PropTypes.number.isRequired,
  csrfToken: PropTypes.string
}

document.addEventListener('DOMContentLoaded', () => {
  const checkoutAnchor = document.getElementById('item-checkout')
  if (!checkoutAnchor) return

  const csrfToken = document.querySelector('[name=csrf-token]')?.content || ''
  const checkoutData = {
    ...JSON.parse(checkoutAnchor.getAttribute('checkout-data')),
    ...{ csrfToken: csrfToken }
  }

  ReactDOM.render(
    <CheckoutButton {...checkoutData} />,
    checkoutAnchor,
  )
})

export default CheckoutButton
