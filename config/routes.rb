StoreApp::Application.routes.draw do
#  devise_for :admins

  root :to => "shop#index"
  resources :products do
    collection { post :search, to: 'products#index' }
  end    

  resources :categories
  resources :orders
  resources :buyers  
  match "/cart" => "buyers#cart"
  match "/addOrderItem/:id" => "orders#addOrderItem"
  match "/removeOrderItem/:id" => "orders#removeOrderItem"  
  match "/confirmOrder/:id" => 'buyers#confirmOrder'

  namespace :admin do
    devise_for :admin
    resources :categories
    resources :products
    resources :orders        
    root :to => "admin#index"
  end
end
