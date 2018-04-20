class TicketsController < ApplicationController
    def new
        
    end
    
    def create
        
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
