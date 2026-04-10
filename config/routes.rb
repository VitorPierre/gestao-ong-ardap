Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

  # Namespace administrativo
  namespace :admin do
    resources :documents
    root "dashboard#index"

    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"

    resources :people
    resources :animals
    resources :adoptions
    resources :foster_cares
    resources :volunteers
    
    resources :documents
    resources :document_links, only: [:create, :destroy]
  end

  # Rotas futuras para cadastro: resources :people, :animals, etc. estarão dentro de admin

  # O sistema será acessível apenas logado, redirecionando para login/admin no root
  root "admin/dashboard#index"
end
