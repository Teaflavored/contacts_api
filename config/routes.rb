Rails.application.routes.draw do
  resources :users, only: [:create, :destroy, :index, :show, :update] do
    get 'favorites'
    resources :groups, only: :index
    resources :contacts, only: :index do
      get 'favorite'
    end
    resources :comments, only: :index
  end

  resources :contacts, only: [:create, :destroy, :show, :update] do 
    resources :comments, only: :index
  end
  resources :contact_shares, only: [:create, :destroy]

  resources :comments, only: [:create, :destroy]

  resources :groups, only: [:create, :destroy] do
    resources :contacts, only: :index
  end
  
  resources :contact_groups, only: [:create, :destroy]
  
end
