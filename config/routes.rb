Rails.application.routes.draw do
  get 'commands/create'

  root to: "effin_quotes#index"
  
  resources :effin_quotes, only: [:index, :show, :destroy, :update] do
    collection do
      get :find
      get :incomplete
      get :check
    end
  end

  resources :commands, only: [:create]
end
