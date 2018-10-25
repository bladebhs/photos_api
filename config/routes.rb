Rails.application.routes.draw do
  post 'auth/register' => 'users#register'
  namespace :api do
    resources :photos, only: [:create, :index]
  end
end
