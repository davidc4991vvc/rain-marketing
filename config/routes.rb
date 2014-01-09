RainCms::Application.routes.draw do
 resources :wechat 
 #routes for market ==============================
  namespace :market do
    resources :keywords
    resources :sites
    resources :todo_items
    get "home/index"
  end

  #routes for admin ==============================
  namespace :admin do
    resources :pages
    resources :channels
    resources :keystores
    get "home/index"
    get "home/help"
    get "templetes/index"
    get "templetes/show"
    get "templetes/new"
    post "templetes/create"
    get "templetes/edit"
    post "templetes/update"
    get "templetes/destroy"
    get "templetes/update_cache"
  end

  #routes for user ==============================
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  mount Ckeditor::Engine => '/ckeditor'
  match 'choose_site', to: "users#choose_site", via: :get
  
  #routes for front ==============================
  root :to => "welcome#index"
  #match '/:profession/:state_code/:dik/:classify_type/(:action(/:id))' => 
  #  'sanction', 
  #  :constraints => { :dik => /\d{4}.\d{2}.\d{2}/,  
  #  :classify_type => /title|date|skip/ }
  match '/:channel(/:id)', to: "welcome#index", via: :get
  match '/:channel(/page/:page)', to: "welcome#index", via: :get

end
