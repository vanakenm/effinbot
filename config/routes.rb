Rails.application.routes.draw do
  get 'commands/create'

  root to: "effin_quotes#index"
  
  resources :effin_quotes, only: [:index, :show] do
    collection do
      get :find
    end
  end

  resources :commands, only: [:create]
end
