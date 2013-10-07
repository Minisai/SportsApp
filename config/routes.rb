SportsApp::Application.routes.draw do
  devise_for :users, :controllers => {:sessions => "users/sessions",
                                      :registrations => "users/registrations"}

  namespace :coaches do
    resource :dashboard, :only => [:show]
    resources :teams, :only => [:show, :index, :create] do
      resources :players, :only => [:create, :destroy], :controller => "teams/players"
    end

    resources :motivations, :only => [:index]
    resources :assessments, :only => [:show, :index, :new, :create]
    resources :players, :only => [:index, :show] do
      member do
        post :motivate
        post :send_message
      end
      collection do
        post :invite
      end
    end
  end

  resources :drills, :only => [:show]
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
