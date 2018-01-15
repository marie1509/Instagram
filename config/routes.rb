Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :favorites, only: [:create, :destroy,:index]
  resources :icons, only: [:new, :create]

  resources :pictures do
    collection do
      post :confirm
    end
  end

end
