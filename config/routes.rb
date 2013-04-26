Mapfeed::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  match "/tweets" => "home#tweets"
  devise_for :users
  resources :users
end
