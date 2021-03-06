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

  #SPA version:
  match "/spa/getProducts" => "spa#getProducts", :via => :get
  match "/spa/getCategories" => "spa#getCategories", :via => :get
  match "/spa/getSessionId" => "spa#getSessionId", :via => :get
  match "/spa/getCurrentBuyer" => "spa#getCurrentBuyer", :via => :get
  match "/spa/sendCurrentBuyer" => "spa#sendCurrentBuyer", :via => :post
  match "/spa/getCart" => "spa#getCart", :via => :get
  match "/spa/sendCart" => "spa#sendCart", :via => :post
  match "/spa/confirmOrder" => "spa#confirmOrder", :via => :post
  match "/spa/searchProducts" => "spa#searchProducts", :via => :post
  match "/spa/" => "spa#index", :via => :get
#  resources :spa

end
