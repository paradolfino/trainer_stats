class TrainingsController < ApplicationController
    #before_action :set_training, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]
    
    def index
        @log = Log.find(params[:log_id])
        @trainigns = @log.trainings
    end
    
    def show
        @log = Log.find(params[:id])
        @training = @log.trainings.find(params[:log_id])
    end
    
    def new
        @log = Log.find(params[:log_id])
        @training = @log.trainings.build
        @trainers = User.all
    end
    
    def create
        @log = Log.find(params[:log_id])
        @training = @log.trainings.build(training_params)
        if @training.save
            create_event("created", "#{@training.stage} training for #{@training.member} from #{@training.company}")
            redirect_to @log
        else
            render 'new'
        end
    end
    
    def edit
        @log = Log.find(params[:id])
        @training = @log.trainings.find(params[:log_id])
        @trainers = User.all
    end
    
    def update
        @log = Log.find(params[:log_id])
        @training = @log.trainings.find(params[:id]) 
        if @training.update(training_params)
            create_event("updated", "#{@training.status} training for #{@training.member} from #{@training.company}")
            redirect_to @log
        else
            render 'edit'
        end
    end
    
    def destroy
        @log = Log.find(params[:id])
        @training = @log.trainings.find(params[:log_id])
        create_event("destroyed", "#{@training.status} training for #{@training.member} from #{@training.company}")
        @training.destroy 
        redirect_to @log
    end
    
    private
    
        def training_params
           params.require(:training).permit(:member, :company, :trainer, :stage, :notes, :status, :log_id) 
        end
        
        def set_training
            @log = Log.find(params[:id])
            @training = @log.trainings.find(params[:log_id]) 
        end
end
