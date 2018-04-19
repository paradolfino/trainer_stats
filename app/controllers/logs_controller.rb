class LogsController < ApplicationController
    
    before_action :set_log, only: [:show, :edit, :destroy]
    
    def index
        @logs = Log.all
    end
    
    def show
        @trainings = @log.trainings    
    end
    
    def new
       @log = Log.new 
    end
    
    def create
        @log = Log.new(params_log)
    end
    
    def edit; end
    
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
