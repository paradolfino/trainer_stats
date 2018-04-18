class TrainingsController < ApplicationController
    def index
        @trainings = Training.order('id DESC')
    end
    
    def new
        @trainings = Training.all.count
        @training = Training.new
    end
    
    def create
        @training = Training.new(training_params)
        if @training.save
            redirect_to '/'
        else
            render 'new'
        end
    end
    
    private
    
        def training_params
           params.require(:training).permit(:member, :company) 
        end
end
