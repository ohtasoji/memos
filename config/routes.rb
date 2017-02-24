Rails.application.routes.draw do
  resources :comments
  root to: 'memos#index'
  resources :memos
  resource :session
  get 'gest/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
