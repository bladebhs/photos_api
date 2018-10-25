Rails.application.routes.draw do
  post 'auth/register' => 'users#register'
  post 'user_token' => 'user_token#create'
  namespace :api do
    resources :photos, only: [:create, :index]
  end
end
