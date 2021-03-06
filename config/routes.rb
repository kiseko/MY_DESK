Rails.application.routes.draw do

  scope module: :public do
    root to: "homes#top"
    resources :users, path: 'deskers/', only: [:show, :edit, :update] do
      resources :scenes, except: [:index, :show]
      resources :followings, except: [:new, :edit, :show]
      resources :clips , only: [:index]
      resource :instagram_link, only: [:create, :update, :destroy]
      resource :twitter_link, only: [:create, :update, :destroy]
      member do
        get 'link'
        get "followers"
        get "mail_setting"
        get "leave"
        patch "resign"
      end
      collection do
        get "search"
      end
      get "timeline/scenes" => "timelines#scene", as: "timeline_scenes"
      get "timeline/items" => "timelines#item", as: "timeline_items"
      get "timeline/reviews" => "timelines#review", as: "timeline_reviews"
    end

    resources :scene_items, path: "scene/:scene_id/scene_items/", only: [:new, :create, :destroy]

    resources :items do
      resources :item_pictures, path: "/pictures", except: [:index, :show]
      resources :genres, only: [:create, :destroy]
      resources :clips , only: [:create, :destroy]
      resource :homepage_link, only: [:create, :update, :destroy]
      resource :amazon_link, only: [:create, :update, :destroy]
      resource :review, except: [:index, :show]
      member do
        get 'link'
      end
      collection  do
        get "search"
      end
    end
  end

  devise_for :users, module: "users"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
