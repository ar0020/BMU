BMU::Application.routes.draw do
  resources :accounts
  resources :savings
  resources :checkings
  resources :mortgages
  resources :credits
  resources :markets

  post "accounts", to: 'accounts/create', as: 'create_account'
  post "accounts", to: 'checking/create', as: 'create_checking'

  resources :transactions, :only => [:index, :show]
  resources :transfers, :only => [:new, :create]
  resources :withdrawals, :only => [:new, :create]
  resources :deposits, :only => [:new, :create]

  get "user/index"
  post "user/index"
  get "user/show/:id", to: 'user#show', as: 'user_show'
  get "teller/create"
  get "teller", to: 'teller#index', as: 'teller_panel'
  get "customer/create"
  get "administrator/create"
  #get "administrator/index"
  get 'administrator', to: 'administrator#index', as: 'admin_panel'
  namespace :administrator do
    root to: "administrator#index"
  end

  #get "home/index"
  devise_for :users, :controllers => { :registrations => 'registrations', :sessions => "sessions"}

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root :to => 'home#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
