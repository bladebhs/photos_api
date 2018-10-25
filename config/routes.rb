Rails.application.routes.draw do
  namespace :api do
    resources :photos, only: [:create, :index]
  end
end
