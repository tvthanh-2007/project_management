Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    namespace :v1 do
      post :login, to: "sessions#create"
      post :refresh, to: "sessions#refresh"
      delete :logout, to: "sessions#logout"
      get :profile, to: "users#show"

      resources :projects do
        resources :invitations, only: :create do
          collection do
            post :accept
          end
        end

        resources :member_projects, only: :update
        member do
          get :joined_members
        end
      end

      resources :users, only: :index
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
