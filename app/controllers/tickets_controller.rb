class TicketsController < ApplicationController
    def new
        @ticket = Ticket.new
    end
    
    def featrequest
        @ticket = Ticket.new
        @code = "feature"
        @prop = "Send a request for a new feature:"
    end
    
    def support
        @ticket = Ticket.new
        @code = "support"
        @prop = "Send a support request:"
    end
    
    def create
        @ticket = Ticket.new(params_tickets)
        if @ticket.save
           redirect_to thanks_path 
        else
            redirect_to thanks_path
        end
    end
    
    def thanks
        
    end
    
    def about
        
    end
    
    private
    
        def params_tickets
            params.require(:ticket).permit(:code, :content)    
        end
end
