class LogsController < ApplicationController
    
    before_action :set_log, only: [:show, :edit, :destroy]
    
    def index
        @logs = Log.order('id DESC')
        respond_to do |format|
            format.json { json_response(@logs) or not_found}
        end
    end
    
    def show
        @trainings = @log.trainings.order('id DESC')
        if @log 
            respond_to do |format|
                format.json { 
                        json_response(@log.to_json(:include => [:trainings]))  
                }
                
            end
        else
           not_found 
        end
        
    end
    
    def new
       @log = Log.new 
    end
    
    def create
        @log = Log.new(params_log)
        if @log.save
           redirect_to @log
        else
            render 'new'
        end
    end
    
    def edit; end
    
    def update
        if @log.update(params_log)
            redirect_to @log
        else
            render 'edit'
        end
    end
    
    def destroy
        @log.destroy
        redirect_to logs_path
        
    end
    
    private
    
        def set_log
           @log = Log.find(params[:id])  if @log
        end
        
        def params_log
            params.require(:log).permit(:title, :active) 
        end
end
