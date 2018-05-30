Rails.application.routes.draw do
  devise_scope :user do
    get "/login" => "devise/sessions#new"
    delete "/logout", to: "devise/sessions#destroy"
    post "/sign_up" => "devise/registrations#create"
  end
  devise_for :users
  root "static_pages#home"
  resources :orders, only: %i(index destroy create) do
    resources :order_details, only: :index
  end
  resource :cart, except: %i(index new edit)
  resources :products, only: [:show, :index]
end
