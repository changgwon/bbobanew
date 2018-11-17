class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	protect_from_forgery with: :exception

	protected
		def configure_permitted_parameters
	      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :userid, :stdnum, :username, :usertype, :cur_cash, :expt_cash])
		  devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :userid, :stdnum, :username, :usertype, :cur_cash, :expt_cash])
		  devise_parameter_sanitizer.permit(:accout_update, keys: [:email, :userid, :stdnum, :username, :usertype, :cur_cash, :expt_cash])
		end
end
