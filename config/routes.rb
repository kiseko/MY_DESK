Rails.application.routes.draw do

  scope module: :public do
    resources :users, path: '/', only: [:show, :edit, :update] do
      resources :items
    end
  end

  devise_for :users, module: "users"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
