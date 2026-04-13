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
    resources :users do
      member do
        patch :toggle_active
      end
    end
    resources :audit_logs, only: [:index]
    
    resources :animals do
      resources :health_records, shallow: true
      resources :vaccination_records, shallow: true
      resources :deworming_records, shallow: true
      resources :medication_records, shallow: true
      resources :weight_records, shallow: true
    end
    
    resources :adoptions
    resources :foster_cares
    resources :volunteers
    
    resources :documents
    resources :document_links, only: [:create, :destroy]

    resources :health_records, only: [:index]
    resources :complaints do
      resources :complaint_updates, only: [:create]
    end
    resources :partners do
      resources :donations, shallow: true, only: [:new, :create, :index]
    end
    resources :donations
    
    resources :documents do
      member do
        get :generate_pdf
        patch :mark_generated
        patch :cancel
      end
      resources :signatures, controller: "document_signatures", only: [:new, :create]
    end
  end

  root "admin/dashboard#index"
end
