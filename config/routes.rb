Rails.application.routes.draw do
  get 'import_sheet/show'
  devise_for :users, controllers: {
    registrations: 'registrations',
    sessions: 'sessions'
  }

  resources :users
  resources :orders
  resources :products
  resources :import_sheet

  devise_scope :user do
    delete '/logout', to: 'sessions#destroy'
  end
end
