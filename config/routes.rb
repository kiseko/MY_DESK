Rails.application.routes.draw do

  scope module: :public do
    root to: "homes#top"
    resources :users, path: '/', only: [:show, :edit, :update] do
      resources :scenes, except: [:index, :show]
      resources :followings, except: [:new, :edit, :show]
      resource :instagram_link, only: [:create, :update, :destroy]
      resource :twitter_link, only: [:create, :update, :destroy]
      member do
        get 'link'
        get "followers"
      end
    end
    resources :scene_items, path: "scene/:scene_id/scene_items/", only: [:new, :create, :destroy]
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
