Rails.application.routes.draw do
  root to: "homes#index"
  devise_for :teachers
  devise_for :users, controllers: {
      sessions:      'users/sessions',
      passwords:     'users/passwords',
      registrations: 'users/registrations'
  }

  resources :users
end
