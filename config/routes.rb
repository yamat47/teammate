# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'homes#show'
  resource :homes, only: [:show]

  namespace :auth do
    resource :session, only: %i[new create destroy]

    get ':provider/callback', to: 'sessions#create'
    get 'failure', to: redirect('/')
    delete 'logout', to: 'sessions#destroy', as: 'logout'
  end
end
