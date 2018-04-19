class TrainingsController < ApplicationController
    before_action :set_training, only: [:edit, :update, :destroy]
    
    def index
        @trainings = Training.order('id DESC')
    end
    
    def new
        @log = Log.find(params[:id])
        @training = @log.trainings.build
    end
    
    def create
        @log = Log.find(params[:id])
        @training = @log.trainings.build(training_params)
        if @training.save
            redirect_to log_trainings_path
        else
            render 'new'
        end
    end
    
    def edit
        
    end
    
    def update
        if @training.update(training_params)
            redirect_to log_trainings_path
        else
            render 'edit'
        end
    end
    
    def destroy
       @training.destroy 
       redirect_to log_trainings_path
    end
    
    private
    
        def training_params
           params.require(:training).permit(:member, :company, :log_id) 
        end
        
        def set_training
            @log = Log.find(params[:id])
            @training = Training.find(params[:id]) 
        end
end
