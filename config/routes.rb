Rails.application.routes.draw do
  resources :images, only: %w[create new show index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'images#index'
end
