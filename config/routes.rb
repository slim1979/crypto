Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :pairs, only: %i[index create show] do
    get :candles, on: :member
  end
end
