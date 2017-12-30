class SubjectController < ApplicationController
    before_action :authenticate_user!
    layout "backend_application"
    protect_from_forgery
    def index
       if current_user.info.is_teacher then
        @subjects = current_user.teaches
       else
        @subjects = current_user.subjects
       end
    
    end
    def show
        @subject = Subject.find(params[:id])
        @announcements = Announcement.where(subject: @subject.id).last(5).reverse
    end
end
