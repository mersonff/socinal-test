Rails.application.routes.draw do
  resources :users

  resources :tasks do
    resources :executions
  end
end
