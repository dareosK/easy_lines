Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # root "pieces#index" # Homepage
  root "pages#home"

  resources :pieces do
    resources :piece_images, only: [:create, :destroy]
    resources :characters, only: [:create, :destroy]
    resources :lines, only: [:create, :destroy]
  end

  # For simulating scenes
  get "pieces/:id/simulate", to: "pieces#simulate", as: :simulate_piece
  get "dashboard", to: "pages#dashboard"
end
