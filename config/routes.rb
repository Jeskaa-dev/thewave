Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'pages#home'

  resources :users do
    resources :skills, only: %i[index]
    resources :user_skills, only: %i[index]
    resources :training_plans, only: %i[show]
  end

  resources :training_plans do
    resources :resources, only: %i[show]

  end
end
