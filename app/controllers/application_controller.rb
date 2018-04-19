class ApplicationController < ActionController::Base
    include Response
    def not_found
        redirect_to '/public/404.html'
    end
end
