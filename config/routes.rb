Rails.application.routes.draw do
  devise_for :users
  root to: 'effin_quotes#home'

  get '/status', to: 'effin_quotes#status'

  get    '/authorize', to: 'oauth#authorize'
  get    '/oauth/callback', to: 'oauth#authorize_callback'
  get    '/success', to: 'oauth#success'
  get    '/error', to: 'oauth#error'

  resources :effin_quotes, only: %i[index show destroy update] do
    collection do
      get :find
      get :incomplete
      get :check
      get :logs
    end
  end

  resources :commands, only: [:create]
end
