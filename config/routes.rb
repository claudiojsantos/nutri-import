Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  defaults format: :json do
    get '/', to: 'health_checks#health'
    resources :products, only: %i[index delete]
    get 'products/:code', to: 'products#show'
    put 'products/:code', to: 'products#update'
    delete 'products/:code', to: 'products#delete'
  end
end
