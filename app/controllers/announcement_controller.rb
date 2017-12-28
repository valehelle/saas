class AnnouncementController < ApplicationController
    def index
    end
    def new
        @announcement = Announcement.new
        @subjects = current_user.teaches
    end
    def create
        @announcement = Announcement.new(announcement_params)
        @announcement.subject = Subject.find(params[:subject][:subject_id])
        if @announcement.save
          flash[:notice] = 'Announcement created!'
          redirect_to dashboard_path
        else
            puts @announcement.errors.messages
          flash[:error] = 'Failed to create announcement!'
          render :new
        end
    end
    private
    def announcement_params
        params.require(:announcement).permit(:title, :content, {:subject => [:subject_id]})
      end
end
