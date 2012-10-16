StoreApp::Application.routes.draw do
  root :to => "shop#index"
  resources :products
  resources :categories
  resources :orders
end
