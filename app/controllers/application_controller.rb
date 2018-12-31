class ApplicationController < ActionController::Base
    include Response
    before_action :configure_permitted_parameters, if: :devise_controller?
    helper_method :is_admin?
    helper_method :trunk
    
    def search_compare(value, string, strict=false)
        if !strict
            if value.downcase.include? string.downcase
                return true
            end
        else
            if value.downcase == string.downcase
               return true 
            end
           
        end
    end
    
    def date_compare(record, fromdate, todate)
        f = Date.strptime(fromdate, '%m/%d/%Y')
        t = Date.strptime(todate, '%m/%d/%Y')
        date_range = (f..t)
        
        if record.date
            if date_range.include? Date.strptime(record.date, '%m/%d/%Y')
                return true
            end
        else
            date = record.created_at.strftime("%m/%d/%Y")
            if date_range.include? Date.strptime(date.to_s, '%m/%d/%Y')
                return true
            end
        end
    end
    
    def multi_param_compare(params, data)
      strict_key="status" #change this if need be
      comparisons = []
      params.each do |key, val|
          strict_key != nil && key == strict_key ?
            data.has_key?(key) && data[key].downcase == val.downcase ?
            comparisons << true : comparisons << false :
            data.has_key?(key) ? data[key].downcase.include?(val.downcase) ? 
            comparisons << true : comparisons << false : nil
          
      end
      comparisons.all? ? true : false
    end
    
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
    
    def require_same_user(user)
        if is_admin?
            if current_user.id != user.id && user.role == "Admin"
                flash[:alert] = "You can't modify or delete other admins!"
                redirect_to '/'
            end
        else    
            if current_user.id != user.id
                flash[:alert] = "Something went wrong!"
                redirect_to '/'
            end
        end
        
    end
    
    def create_event(action, content)
        @event = Event.create(action: action, content: content, user_id: current_user.id)
    end
    
    def trunk(string, max=30)
       string.truncate(max) 
    end

    
    protected
    
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:fullname])
        devise_parameter_sanitizer.permit(:edit, keys: [:fullname])
    end
end
