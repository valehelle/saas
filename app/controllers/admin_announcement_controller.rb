class AdminAnnouncementController < ApplicationController
        before_action :authenticate_user!
    layout "admin_application"
    protect_from_forgery
    def index
        @announcements = Announcement.all.paginate(:page => params[:page], :per_page => 10)
    end
    def show
        @announcement = Announcement.find_by_id(params[:id])
    end
    def new
        @announcement = Announcement.new
    end
    def create
        @announcement = Announcement.new(announcement_params)
        if @announcement.save
            redirect_to admin_announcement_index_path, notice: "Announcement succesfully created!" 
        else
            render :new
        end
    end
    def edit
        @announcement = Announcement.find(params[:id])
    end
    def update
        @announcement = Announcement.find(params[:id])
        if @announcement.update_attributes(announcement_params)
            redirect_to admin_student_path(@user), notice: "Updated Announcement."
        else
            render :edit
        end
    end
    def destroy
        @announcement = Announcement.find(params[:id])
            if @announcement.delete
                flash[:notice] = 'Announcement deleted!'
                redirect_to admin_announcement_index_path
                
            else
                flash[:error] = 'Failed to delete this announcement!'
                render :destroy
            end
    end

    private

    def announcement_params
        params.require(:announcement).permit( :title, :subject_id, :content)
    end
end
