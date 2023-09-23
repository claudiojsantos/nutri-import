Rails.application.routes.draw do
  defaults format: :json do
    resources :products, only: [:index, :show, :update, :delete]
  end
end
