Rails.application.routes.draw do
  root to: "effin_quotes#home"
  
  get 'commands/create'
  get    '/authorize', to: 'oauth#authorize'                                       
  get    '/oauth/callback', to: 'oauth#authorize_callback'  

  resources :effin_quotes, only: [:index, :show, :destroy, :update] do
    collection do
      get :find
      get :incomplete
      get :check
    end
  end

  resources :commands, only: [:create]
end
