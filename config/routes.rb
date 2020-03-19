Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: "homes#index"

  devise_for :teachers, controllers: {
      sessions:      'teachers/sessions',
      passwords:     'teachers/passwords',
      registrations: 'teachers/registrations'
  }

  devise_for :users, controllers: {
      sessions:      'users/sessions',
      passwords:     'users/passwords',
      registrations: 'users/registrations'
  }

  namespace :users do
    resources :lessons, only: [:index]
    resources :reservations, only: %i[index new create]
    resources :charges, only: %i[new create]
  end

  namespace :teachers do
    resources :reservations, only: [:index]
    resources :lessons
  end


  devise_scope :teacher do
    resources :teachers, only: [] do
      get "masquerade", to: "teachers/sessions#masquerade_sign_in", on: :member
    end
    get "back_to_owner", to: "teachers/sessions#back_to_owner"
  end

  resources :teachers, only: %i[index destroy] do
    get :profile, action: :profile, on: :collection
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/lo'
  end
end
