Rails.application.routes.draw do
  root to: 'users#index'
  resources :users do
    get 'favorites'
    resources :groups, only: :index
    resources :contacts, only: :index do
      get 'favorite'
    end
    resources :comments, only: :index
  end

  resources :contacts do 
    resources :comments, only: :index
  end
  resources :contact_shares, only: [:create, :destroy]

  resources :comments, only: [:create, :destroy]

  resources :groups, only: [:create, :destroy] do
    resources :contacts, only: :index
  end
  
  resources :contact_groups, only: [:create, :destroy]
  resource :session, only: [:create, :destroy, :new]
end
