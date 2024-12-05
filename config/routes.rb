Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }, skip: [:sessions]
  as :user do
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end
  root to: 'pages#home'

  resources :users do
    resources :user_skills, only: %i[index]
    resources :training_plans, only: %i[show]
    resources :questions, only: %i[index create] do
      collection do
        post :chat
      end
    end
  end
  
  resources :resources do
    member do
      post :complete
    end
  end

  get 'portfolio', to: 'pages#portfolio'

end
