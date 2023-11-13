# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :movies do
    resources :comments, shallow: true
    post 'add_to_watchlist'
    post 'remove_from_watchlist'
  end

  resources :watchlist, only: %i[index destroy]
end
