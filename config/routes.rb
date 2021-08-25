# frozen_string_literal: true

# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    devise_for :users, controllers: { sessions: :sessions },
                       path: 'auth',
                       path_names: { sign_in: :login }

    resource :user, only: %i[show update]
  end

  root to: 'application#status'
end
