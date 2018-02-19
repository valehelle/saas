class SubjectController < ApplicationController
    before_action :auth_user
    layout "backend_application"
    protect_from_forgery
    def index
       if current_user.info.is_teacher then
        @subjects = current_user.teaches
       else
        @subjects = current_user.subjects
       end
       @dashboard_title = 'Subject'
    
    end
    def show
        @subject = Subject.find(params[:id])
        @dashboard_title = 'Subject'
        @announcements = Announcement.where(subject: @subject.id).last(5).reverse
    end
    def announcements
         @subject = Subject.find(params[:id])
         @dashboard_title = 'Subject'
         @announcements = Announcement.where(subject: @subject.id).paginate(:page => params[:page], :per_page => 10)
    end
end
