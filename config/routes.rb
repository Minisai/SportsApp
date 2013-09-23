SportsApp::Application.routes.draw do
  devise_for :users, :controllers => {:sessions => "users/sessions",
                                      :registrations => "users/registrations"}

  namespace :coaches do
    resource :dashboard, :only => [:show]
    resources :teams, :only => [:show, :index, :create] do
      resources :players, :only => [:create, :destroy], :controller => "teams/players"
    end

    resources :motivations, :only => [:index]
    resources :players, :only => [:index, :show, :create] do
      member do
        post :motivate
        post :send_message
      end
    end
  end

  resources :pricing_plans, :only => [:index]

  resources :payments do
    collection do
      get :paypal_checkout
      get :paypal_callback
    end
  end
  namespace :angular do
    resources :templates, :only => [:show]
  end

  root :to => "home#index"
end
