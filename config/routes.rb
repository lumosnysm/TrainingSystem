Rails.application.routes.draw do
  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"
  root to: "static_pages#home"
  devise_for :users, path: "account",
    controllers: {sessions: "sessions", registrations: "users"}
  devise_scope :user do
    match "/users/:id", to: "users#show", via: "get"
  end
  resources :users
  resources :reports do
    get "page/:page", action: :index, on: :collection
  end
  resources :courses do
    resources :subjects, only: %i(show update) do
      resources :user_subjects
    end
  end
  namespace :supervisor do
    resources :members
    resources :users
    resources :courses do
      resources :subjects
    end
  end
end
