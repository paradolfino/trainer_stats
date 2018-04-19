class ApplicationController < ActionController::Base
    include Response
    def not_found
        raise ActionController::RoutingError.new('Not Found')
    end
end
