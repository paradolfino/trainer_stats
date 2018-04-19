class LogsController < ApplicationController
    
    before_action :set_log, only: [:show, :edit, :destroy]
    before_action :total_trainings
    
    def index
        @logs = Log.where(active: true).order('id DESC')
        @active = @logs.count
        @total = Log.all.count
        respond_to do |format|
            format.html
            format.json { json_response(@logs)}
        end
        
    end
    
    def inactive
        @logs = Log.where(active: false).order('id DESC')
        @inactive = @logs.count
        @total = Log.all.count
        
        respond_to do |format|
            format.html
            format.json { json_response(@logs)}
        end
    end
    
    def show
        @trainings = @log.trainings.order('id DESC')
        
        respond_to do |format|
            format.html
            format.json { 
                    json_response(@log.to_json(:include => [:trainings]))  
            }
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
        @log = Log.find(params[:id])
        if @log.update(params_log)
            redirect_to logs_path
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
           if Log.where(id: params[:id]).exists?
               @log = Log.find(params[:id])
           else
               not_found
               
           end
        end
        
        def params_log
            params.require(:log).permit(:title, :active) 
        end
        
        def all_trainings(logs)
            training_arr = []
            logs.each do |l|
                l.trainings.count >> training_arr
            end
        end
        
        def total_trainings
            @logs = Log.all
            @total_trainings = all_trainings(@logs)
        end
end
