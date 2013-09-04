SportsApp::Application.routes.draw do
  devise_for :users, :controllers => {:sessions => "users/sessions",
                                      :registrations => "users/registrations"}

  namespace :coaches do
    resource :dashboard, :only => [:show]
    resources :players, :only => [:index, :show]
  end

  root :to => "home#index"
end
