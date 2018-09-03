Rails.application.routes.draw do
  root to: "static_pages#home"
  devise_for :users, path: "account",
    controllers: {sessions: "sessions", registrations: "users"}
  resources :users
  resources :user_courses, only: %i(index show)
  resources :courses do
    resources :subjects, only: :show
  end
  namespace :supervisor do
    resources :members
    resources :courses do
      resources :subjects
    end
  end
end
