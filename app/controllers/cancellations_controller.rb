class CancellationsController < ApplicationController
    #before_action :set_cancellation, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:show]
    
    
    def show
        @log = CancellationLog.find(params[:id])
        @cancellation = @log.cancellations.find(params[:cancellation_log_id])
        @title = "#{@log.title}"
    end
    
    def new
        @log = CancellationLog.find(params[:cancellation_log_id])
        @cancellation = @log.cancellations.build
        @title = "New Cancellation"
    end
    
    def create
        @log = CancellationLog.find(params[:cancellation_log_id])
        @cancellation = @log.cancellations.build(cancellation_params)
        if @cancellation.save
            create_event("created", "#{@cancellation.reason} cancellation for #{@cancellation.member} from #{@cancellation.company}")
            redirect_to @log
        else
            render 'new'
        end
    end
    
    def edit
        @log = CancellationLog.find(params[:id])
        @cancellation = @log.cancellations.find(params[:cancellation_log_id])
        @title = "Edit Cancellation"
    end
    
    def update
        @log = CancellationLog.find(params[:cancellation_log_id])
        @cancellation = @log.cancellations.find(params[:id]) 
        if @cancellation.update(cancellation_params)
            create_event("updated", "#{@cancellation.reason} cancellation for #{@cancellation.member} from #{@cancellation.company}")
            redirect_to @log
        else
            render 'edit'
        end
    end
    
    def destroy
        @log = CancellationLog.find(params[:id])
        @cancellation = @log.cancellations.find(params[:cancellation_log_id])
        create_event("destroyed", "#{@cancellation.reason} cancellation for #{@cancellation.member} from #{@cancellation.company}")
        @cancellation.destroy 
        redirect_to @log
    end
    
    private
    
        def cancellation_params
           params.require(:cancellation).permit(:member, :company, :reason, :notes, :cancellation_log_id) 
        end
        
        def set_cancellation
            @log = CancellationLog.find(params[:id])
            @cancellation = @log.cancellations.find(params[:cancellation_log_id]) 
        end
end
