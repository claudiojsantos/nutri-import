Rails.application.routes.draw do
  defaults format: :json do
    get '/', to: 'health_checks#health'
    resources :products, only: [:index, :show, :update, :delete]
  end
end
