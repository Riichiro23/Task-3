Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'about', to: 'homes#about'
   resources :users, only:[:index, :show, :edit, :update]
    resources :books, only: [:create, :show, :index, :edit, :update, :destroy]
end