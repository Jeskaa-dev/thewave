Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'pages#home'

  resources :users do
    resources :user_skills, only: %i[index]
    resources :training_plans, only: %i[show]
  end
  resources :resources do
    member do
      post :complete
    end
  end
end
