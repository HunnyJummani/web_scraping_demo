Rails.application.routes.draw do
  resources :web_scrappers

  get "download", to: 'web_scrappers#download', as: :download
  root 'web_scrappers#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
