BMU::Application.routes.draw do

  resources :bills
  get 'bills/start/:id', to: 'bills#enable', as: 'start_recurrence'
  get 'bills/stop/:id', to: 'bills#disable', as: 'stop_recurrence'

  resources :accounts, :only => [:index, :show, :update, :destroy]
  get 'accounts/enable/:id', to: 'accounts#enable', as: 'enable_account'
  get 'accounts/disable/:id', to: 'accounts#disable', as: 'disable_account'
  resources :savings, :only => [:new, :create]
  resources :checkings, :only => [:new, :create]
  resources :mortgages, :only => [:new, :create]
  resources :credits, :only => [:new, :create]
  resources :markets, :only => [:new, :create]

  resources :transactions, :only => [:index]
  resources :transfers, :only => [:new, :create]
  #resources :withdrawals, :only => [:new, :create]
  #resources :deposits, :only => [:new, :create]
  get 'withdrawals/new', to: 'withdrawals#new', as: 'new_withdrawal'
  get 'withdrawals/new/:id', to: 'withdrawals#new', as: 'new_withdrawal_from_account'
  post 'withdrawals/create', to: 'withdrawals#create', as: 'withdrawals'
  get 'deposits/new', to: 'deposits#new', as: 'new_deposit'
  get 'deposits/new/:id', to: 'deposits#new', as: 'new_deposit_to_account'
  post 'deposits/create', to: 'deposits#create', as: 'deposits'

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
