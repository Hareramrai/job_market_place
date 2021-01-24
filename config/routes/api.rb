namespace :api, defaults: { format: 'json' } do
  namespace :v1 do
    resources :users, only: %I[create update]
    resources :jobs, only: %I[index create]
    
    post 'login', to: 'sessions#create', as: 'login'
  end
end