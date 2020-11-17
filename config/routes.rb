Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :users, only: [:create] do
    collection do 
      get :sign_up 
      get :edit
      patch :update
      get :sign_in
      post :login
      delete :sign_out
    end
  end
end
