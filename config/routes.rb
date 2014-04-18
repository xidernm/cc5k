Myapp::Application.routes.draw do
  resources :missions

  resources :answers

  resources :statistics

  resources :usage_types

  resources :region_statistics

  resources :factors

  resources :earned_badges

  resources :regions

  resources :badges

  root :to => "home#index"
  devise_for :users do 
    get "/users/sign_out" => "devise/sessions#destroy", :as => :destroy_user_session 
    get 'users/:id' => 'users#show'
  end 
  devise_for :controllers => {:registrations => "registrations", :calculators => "calculators"}
  resources :users
  get "/contribution", to: "home#contribution", as: "contribution"
  get "/emissions_tempate", to: "statistics#emissions_template", as: "emissions_template" 
  get "/month_chart", to: "home#contribution", as: "month_chart" 
  post "/create_answer_from_input", to: "statistics#create_answer", as: "create_answer"
  get "/fill_in_factors", to: "statistics#fill_in_factors", as: "fill_in_factors" 
  post "/submit_factor_changes", to: "statistics#submit_factor_changes", as: "submit_factor_changes" 
  get "/wizard", to:"wizard#index", as:"wizard"
  get "/mission_objective", to: "mission_objective#index", as: "mission_objective"
  post "/update_anon", to: "anon_users#update", as: "update_anon"
  get "/missions_wizard", to: "wizard#index_from_missions", as: "mission_explorer"
end
