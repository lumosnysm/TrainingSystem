Rails.application.routes.draw do
  root to: "static_pages#home"
  devise_for :users, path: "account",
    controllers: {sessions: "sessions", registrations: "users"}
  resources :users
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
