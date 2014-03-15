Myapp::Application.routes.draw do
  resources :answers

  resources :statistics

  resources :usage_types

  resources :region_statistics

  resources :factors

  resources :earned_badges

  resources :regions

  resources :badges

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations", :calculators => "calculators"}
  resources :users
  
  get "/user_input_form", to: "statistics#fill_out_form", as: "fill_out_form" 
  post "/create_answer_from_input", to: "statistics#create_answer", as: "create_answer"
  get "/fill_in_factors", to: "statistics#fill_in_factors", as: "fill_in_factors" 
  post "/submit_factor_changes", to: "statistics#submit_factor_changes", as: "submit_factor_changes" 
end
