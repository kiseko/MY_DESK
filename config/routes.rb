Rails.application.routes.draw do

  scope module: :public do
    resources :users, path: '/', only: [:show, :edit, :update]
    resources :items do
      resources :item_pictures, path: "/pictures", except: [:index, :show]
      resource :homepage_link, only: [:create, :update, :destroy]
       resource :amazon_link, only: [:create, :update, :destroy]
      resource :review, except: [:index, :show]
      resources :genres, only: [:create, :destroy]
      member do
        get 'link'
      end
    end
  end

  devise_for :users, module: "users"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
