Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  devise_for :users
  root to: 'homes#top'
   resources :users, only:[:index, :show, :edit, :update]
    resources :books, only: [:create, :show, :index, :edit, :update, :destroy]
end