class ApplicationController < ActionController::Base
    include Response
    before_action :configure_permitted_parameters, if: :devise_controller?
    helper_method :is_admin?
    
    def not_found
        redirect_to '/public/404.html'
    end
    
    def is_admin?
        return true if current_user && current_user.role == "Admin"
        false
    end
    
    def require_admin
        if !is_admin?
           flash[:alert] = "You must be an admin to view this!"
           redirect_to '/'
        end
    end

    
    protected
    
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
        devise_parameter_sanitizer.permit(:edit, keys: [:name])
    end
end
