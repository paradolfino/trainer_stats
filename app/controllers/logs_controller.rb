class LogsController < ApplicationController
    
    before_action :set_log, only: [:show, :edit, :destroy]
    
    def index
        @logs = Log.all
    end
    
    def show
        
    end
    
    def edit
        
    end
    
    def update
        
    end
    
    def destroy
        
    end
    
    private
    
        def set_log
           @log = Log.find(params[:id]) 
        end
        
        def params_log
            params.require(:log).permit(:title, :active) 
        end
end
