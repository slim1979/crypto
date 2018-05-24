Rails.application.routes.draw do
  resources :tickers
  resources :trades
  resources :candles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :pairs, only: %i[index create show] do
    get :history, on: :member
  end
end
