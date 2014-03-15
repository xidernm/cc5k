class RegistrationsController < Devise::RegistrationsController
  before_filter :update_sanitized_params, if: :devise_controller?

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:firstName, :lastName, :email,:state, :password, :password_confirmation)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:firstName, :lastName, :email,:state, :password, :password_confirmation, :current_password)}
  end
  $stateMap = {"Alabama"=>"Alabama","Alaska"=>"Alaska","Arizona"=>"Arizona","Arkansas"=>"Arkansas","California"=>"California","Colorado"=>"Colorado","Connecticut"=>"Connecticut","Delaware"=>"Delaware","District of Columbia"=>"District Of Columbia","Florida"=>"Florida","Georgia"=>"Georgia","Hawaii"=>"Hawaii","Idaho"=>"Idaho","Illinois"=>"Illinois","Indiana"=>"Indiana","Iowa"=>"Iowa","Kansas"=>"Kansas","Kentucky"=>"Kentucky","Louisana"=>"Louisiana","Maine"=>"Maine","Maryland"=>"Maryland","Massachusetts"=>"Massachusetts","Michigan"=>"Michigan","Minnesota"=>"Minnesota","Mississippi"=>"Mississippi","Missouri"=>"Missouri","Montana"=>"Montana","Nebraska"=>"Nebraska","Nevada"=>"Nevada","New Hampshire"=>"New Hampshire","New Jersey"=>"New Jersey","New Mexico"=>"New Mexico","New York"=>"New York","North Carolina"=>"North Carolina","North Dakota"=>"North Dakota","Ohio"=>"Ohio","Oklahoma"=>"Oklahoma","Oregon"=>"Oregon","Pennsylvania"=>"Pennsylvania","Rhode Island"=>"Rhode Island","South Carolina"=>"South Carolina","South Dakota"=>"South Dakota","TennesseN"=>"Tennessee","Texas"=>"Texas","Utah"=>"Utah","Vermont"=>"Vermont","Virginia"=>"Virginia","Washington"=>"Washington","West Virginia"=>"West Virginia","Wisconsin"=>"Wisconsin","Wyoming"=>"Wyoming"}




end
