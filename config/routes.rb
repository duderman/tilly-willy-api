# frozen_string_literal: true

Rails.application.routes.draw do
  resources :products, only: :index
  resources :checkouts, only: :create
end
