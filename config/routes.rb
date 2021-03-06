Rails.application.routes.draw do
  namespace :api do
    resource  :registrations, only: %i(create)
    resource  :sessions, only: %i(create destroy)
    resource  :profiles, only: %i(show update)
    resources :entries, only: %i(index show create update destroy)
    resources :users, only: %i(index show create update destroy)
    resources  :exports, only: %i(index)
  end

  root to: 'application#home'
end
