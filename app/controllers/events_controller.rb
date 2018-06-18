class EventsController < ApplicationController
    before_action :require_admin
    
    def audit
        @events = Event.all.order('id DESC')
        @title = "Audit Trail"
    end
    
    def create
       @event = Event.new(event_params) 
    end
    
    
    private
        
        def event_params
           params.require(:event).permit(:action, :content, :user_id) 
        end
    
end
