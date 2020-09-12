Rails.application.routes.draw do
  root 'public/homes#top'
  get '/search' => 'search#search'
  get 'contacts' => 'contacts#new'
  post 'contacts' => 'contacts#create'
  
  # Public側ルーティング
  devise_for :end_users, controllers: {
    registrations: 'public/devise/registrations',
    passwords:'public/devise/passwords',
    sessions:'public/devise/sessions',
  }
  devise_scope :end_user do
    post 'guest_sign_in' => 'public/devise/sessions#new_guest'
  end

  namespace :public do
    get 'homes/top' => 'homes#top', as: 'top'
    get 'homes/terms' => 'homes#terms', as: 'terms'
    
    resources :end_users, only:[:edit,:show,:update] do
      member do
        patch :withdraw
      end
      resource :relationships, only: [:create, :destroy]
    end
    
    resources :cocktails do
      resource :favorites, only: [:create, :destroy]
      resources :rates, only: [:create, :destroy]
      post :search, on: :collection
    end
    
    resources :ingredients, only:[:index,:show] do
      post :search, on: :collection
    end
  end

  # Admin側ルーティング
  devise_scope :admins do
    devise_for :admins, controllers: {
      sessions: 'admins/devise/sessions',
    }
  end

  namespace :admins do
    get 'homes/top' => 'homes#top', as:'top'
    resources :end_users, only: [:index, :edit, :show, :update] do
      member do
        patch :withdraw
        patch :unfreeze
      end
    end
    resources :cocktails do
      collection do
        get :get_api_cocktails
        get :get_cocktail_image
        post :search
        get :similar_cocktail
      end
    end
    resources :ingredients, only: [:index, :create, :destroy] do
      post :search, on: :collection
    end
  end
    
end
