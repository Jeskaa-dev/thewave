Rails.application.routes.draw do
  get 'users/show'
  devise_for :users

  root to: 'pages#home'

  resources :users do
    resources :skills, only: %i[index]
    resources :user_skills, only: %i[index]
  end

  resources :training_plans do
    resources :resources, only: %i[index]
    resources :skills, only: %i[index]
  end
end
