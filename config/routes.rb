Rails.application.routes.draw do
  root to: "static_pages#home"
  get "/supervisor", to: "supervisor/static_pages#home"
  devise_for :users, :path => 'accounts'
  resources :users do
    resources :courses, only: %i(index show) do
      resources :subjects, only: %i(index show)
    end
  end
  namespace :supervisor do
    resources :courses
  end
end
