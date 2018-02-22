class FrontController < ApplicationController
    
    def index
        UserMailer.announcement_email("HELOOO").deliver_now
    end
    
    def about
    
    end


end
