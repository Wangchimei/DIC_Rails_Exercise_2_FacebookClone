Rails.application.routes.draw do
  resources :feeds do
    collection do 
      post :confirm
    end
  end
  
  resources :feeds do
    resources :comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:new, :create, :edit, :update, :show]
  resources :sessions, only: [:new, :create, :destroy]
  
  root to: 'feeds#home'
end
