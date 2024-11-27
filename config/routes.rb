Rails.application.routes.draw do
  get 'user_skills/index'
  get 'skills/index'
  get 'skills/show'

  devise_for :users

  root to: 'home#index'

<<<<<<< HEAD
  # Defines the root path route ("/")
  root "resources#index"

resources :resources
=======
  resources :users do
    resources :skills, only: %i[index]
    resources :user_skills, only: %i[index]
  end
>>>>>>> master

  resources :training_plans do
    resources :resources, only: %i[index]
    resources :skills, only: %i[index]
  end
end
