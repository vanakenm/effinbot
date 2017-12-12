Rails.application.routes.draw do
  root to: "effin_quotes#index"
  
  resources :effin_quotes, only: [:index, :show] do
    collection do
      get :find
    end
  end
end
