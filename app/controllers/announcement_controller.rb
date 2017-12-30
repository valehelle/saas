class AnnouncementController < ApplicationController
    before_action :authenticate_user!
    layout "backend_application"
    protect_from_forgery
    def index
        @announcements = Announcement.paginate(:page => params[:page], :per_page => 10)
    end
    def show
        @announcement = Announcement.find(params[:id])
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
          flash[:error] = 'Failed to create announcement!'
          render :new
        end
    end
    def destroy
        @announcement = Announcement.find(params[:id])
        if @announcement.delete
            flash[:notice] = 'Announcement deleted!'
            redirect_to announcements_path
            
        else
            flash[:error] = 'Failed to delete this announcement!'
            render :destroy
        end
    end
    private
    def announcement_params
        params.require(:announcement).permit(:title, :content, {:subject => [:subject_id]})
      end
end
