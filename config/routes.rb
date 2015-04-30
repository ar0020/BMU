BMU::Application.routes.draw do

  root to: 'sessions#new'

  # get 'test', to: 'test#index'
  # get 'test/credit_rate', to: 'test#credit_rate'
  # get 'test/market_rate', to: 'test#market_rate'
  # get 'test/saving_rate', to: 'test#saving_rate'
  # get 'test/bill_pay', to: 'test#bill_pay'
  # get 'test/mortgages_behind', to: 'test#mortgages_behind'

  # get 'bills/start/:id', to: 'bills#enable', as: 'start_recurrence'
  # get 'bills/stop/:id', to: 'bills#disable', as: 'stop_recurrence'
  # get 'bills/new', to: 'bills#new', as: 'new_bill'
  # get 'bills/new/:id', to: 'bills#new', as: 'bill_by_id'
  # post 'bills/create', to: 'bills#create', as: 'bills'
  resources :bills

  resources :accounts
  # get 'accounts', to: 'accounts#index'
  # post 'accounts', to: 'accounts#index'
  # get 'accounts/enable/:id', to: 'accounts#enable', as: 'enable_account'
  # get 'accounts/disable/:id', to: 'accounts#disable', as: 'disable_account'
  
  resources :savings
  resources :checkings
  resources :mortgages
  resources :credits
  resources :markets

  resource :transactions
  resource :transfers
  resource :withdrawals
  resource :deposits
  resource :sessions

  resource :users
  
  
  #transactions
  # get 'transactions', to: 'transactions#index', as: 'transactions'

  # get 'transfers/new', to: 'transfers#new', as: 'new_transfer'
  # get 'transfers/new/:id', to: 'transfers#new', as: 'transfer_by_id'
  # post 'transfers/create', to: 'transfers#create', as: 'transfers'

  # get 'withdrawals/new', to: 'withdrawals#new', as: 'new_withdrawal'
  # get 'withdrawals/new/:id', to: 'withdrawals#new', as: 'withdraw_by_id'
  # post 'withdrawals/create', to: 'withdrawals#create', as: 'withdrawals'

  # get 'deposits/new', to: 'deposits#new', as: 'new_deposit'
  # get 'deposits/new/:id', to: 'deposits#new', as: 'deposit_by_id'
  # post 'deposits/create', to: 'deposits#create', as: 'deposits'


  # get "users", to: 'user#index', as: 'users'
  # post "users", to: 'user#index'
  # get "teller", to: 'teller#index', as: 'teller_panel'
  # #get "administrator/index"
  # get 'administrator', to: 'administrator#index', as: 'admin_panel'
  # get "customer/:id", to: 'customer#index', as: 'customer_by_id'
  # get "customer/", to: 'customer#index', as: 'customer'

  #get "home/index

end
