StoreApp::Application.routes.draw do
  root :to => "shop#index"
  resources :products
  resources :categories
  resources :orders
  resources :buyers  
  match "/cart" => "buyers#cart"
  match "/addOrderItem/:id" => "orders#addOrderItem"
  match "/removeOrderItem/:id" => "orders#removeOrderItem"  
  match "/confirmOrder/:id" => 'buyers#confirmOrder'
end
