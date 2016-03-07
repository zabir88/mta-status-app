Rails.application.routes.draw do
  root to: 'statuses#index'
  post "statuses/index"
end
