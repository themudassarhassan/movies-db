# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :movies do
    resources :comments
    post 'add_to_watchlist'
    delete 'remove_from_watchlist'
  end

  resources :watchlist, only: %i[index destroy]
end
