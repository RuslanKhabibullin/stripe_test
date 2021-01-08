Rails.application.routes.draw do
  mount StripeEvent::Engine, at: "/stripe/webhook"

  devise_for :users, controllers: { registrations: "users/registrations" }

  get "items/:item_id/payments/success" => "items/payments#success", as: :item_payment_success
  get "items/:item_id/payments/cancel" => "items/payments#cancel", as: :item_payment_cancel

  resources :items, only: %i[index show] do
    resources :payments, only: %i[create], module: :items
  end

  resources :users, only: %i[] do
    resources :items, only: %i[index], module: :users
    resources :payment_sessions, only: %i[index], module: :users
  end

  root to: "items#index"
end
