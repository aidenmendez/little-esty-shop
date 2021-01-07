Rails.application.routes.draw do
  
namespace :api do
  get "/github_api", to: "github_api#index", as: 'github_index'
end

resources :merchants do
  resources :items
  resources :invoices
  resources :dashboard, only: [:index]
end

  namespace :admin do
    resources :merchants
    resources :invoices
  end
  resources :admin, controller: 'admin/dashboard', only: [:index]
end
