class CancellationLogsController < ApplicationController
    
    before_action :set_log, only: [:show, :edit, :destroy]
    before_action :total_cancellations, only: [:index]
    before_action :authenticate_user!, except: [:index, :show]
    
    def index
        
        @logs = CancellationLog.order('id DESC')
        @total = CancellationLog.all.count
        respond_to do |format|
            format.html
            format.json { json_response(@all_logs)}
        end
        @title = "Cancellation Logs"
    end
    
    
    def show
        
        if params[:sort]
            @cancellations = @log.cancellations.where(reason: params[:sort]).order('id DESC')
        else
            @cancellations = @log.cancellations.order('id DESC')
        end
        @count = @cancellations.count
        
        respond_to do |format|
            format.html
            format.json { 
                    json_response(@log.to_json(:include => [:cancellations]))  
            }
            format.csv { send_data @cancellations.to_csv, filename: "#{@log.title}.csv" }
            format.xls { send_data @cancellations.to_csv(col_sep: "\t"), filename: "#{@log.title}.xls" }
        end
        @title = @log.title
        
    end
    
    def new
       @log = CancellationLog.new
       @title = "New Cancellation Log"
    end
    
    def create
        @log = CancellationLog.new(params_log)
        if @log.save
            create_event("created", "cancellation log with ID: #{@log.id}, Title: #{@log.title}")
            redirect_to @log
        else
            render 'new'
        end
    end
    
    def edit
        @title = "Edit Cancellation Log"    
    end
    
    def update
        
        @log = CancellationLog.find(params[:id])
        @old_title = @log.title
        if @log.update(params_log)
            create_event("updated", "cancellation log with ID: #{@log.id}, Title: #{@old_title} to (Title: #{@log.title})")
            redirect_to logs_path
        else
            render 'edit'
        end
    end
    
    def destroy
        create_event("destroyed", "cancellation log with ID: #{@log.id}, Title: #{@log.title}")
        @log.destroy
        redirect_to cancellation_logs_path
        
    end
    
    private
    
        def set_log
           if CancellationLog.where(id: params[:id]).exists?
               @log = CancellationLog.find(params[:id])
           else
               not_found
               
           end
        end
        
        def params_log
            params.require(:cancellation_log).permit(:title) 
        end
        
        def all_cancellations(logs)
            cancellations_arr = []
            logs.each do |l|
                 cancellations_arr.push(l.cancellations.count)
            end
            cancellations_arr.reduce(&:+)
        end
        
        def total_cancellations
            @all_logs = CancellationLog.all
            @total_cancellations = all_cancellations(@all_logs)
        end
        
        
end
