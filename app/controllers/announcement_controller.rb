class AnnouncementController < ApplicationController
    before_action :authenticate_user!
    layout "backend_application"
    protect_from_forgery
    def index
        @announcements = Announcement.where(company_id: current_user.info.company_id).paginate(:page => params[:page], :per_page => 10)
        @dashboard_title = 'Announcement'
    end
    def show
        @announcement = Announcement.find(params[:id])
        @dashboard_title = 'Announcement'
    end
    def new
        @announcement = Announcement.new
        @subjects = current_user.teaches
        @dashboard_title = 'Announcement'
    end
    def create
        @announcement = Announcement.new(announcement_params)
        @announcement.subject = Subject.find(params[:subject][:subject_id])
        if @announcement.save
          flash[:notice] = 'Announcement created!'
          redirect_to dashboard_path
        else
          flash[:alert] = 'Failed to create announcement!'
          render :new
        end
    end
    def destroy
        @announcement = Announcement.find(params[:id])
        if @announcement.delete
            flash[:notice] = 'Announcement deleted!'
            redirect_to announcements_path
            
        else
            flash[:alert] = 'Failed to delete this announcement!'
            render :destroy
        end
    end
    private
    def announcement_params
        params.require(:announcement).permit(:title, :content, {:subject => [:subject_id]})
      end
end
