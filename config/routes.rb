Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  devise_for :users, controllers: { registrations: 'patients/registrations' }
  root 'home#index'
  resources :doctors, except: :destroy
  resources :patients, only: :index
  resources :categories, except: :destroy
  resources :appointments

  mount LetterOpenerWeb::Engine, at: '/letter_opener' unless Rails.env.test?
end
