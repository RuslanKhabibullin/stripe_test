Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :items, only: %i[index show]

  root to: "items#index"
end
