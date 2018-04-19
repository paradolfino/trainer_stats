class ApplicationController < ActionController::Base
    include Response
    def not_found
        render '#{Rails.root}/public/404}'
    end
end
