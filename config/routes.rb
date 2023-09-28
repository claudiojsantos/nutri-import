Rails.application.routes.draw do
  defaults format: :json do
    get '/', to: 'health_checks#health'

    resources :products, only: %i[index update delete]

    get 'products/:code', to: 'products#show'
    delete 'products/:code', to: 'products#delete'
  end
end
