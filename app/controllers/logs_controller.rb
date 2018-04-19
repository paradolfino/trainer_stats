class LogsController < ApplicationController
    
    def index
        @logs = Logs.all
    end
    
end
