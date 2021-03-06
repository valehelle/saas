class AdminAnnouncementController < ApplicationController
        before_action :authenticate_user!
    layout "admin_application"
    protect_from_forgery
    def index
        @announcements = Announcement.where(company_id: current_user.info.company_id).paginate(:page => params[:page], :per_page => 10)
        
    end
    def show
        @announcement = Announcement.find_by_id(params[:id])
    end
    def new
        @announcement = Announcement.new
    end
    def create
        @announcement = Announcement.new(announcement_params)
        if !params[:subject_id].empty?
            @announcement.subject = Subject.find(params[:subject_id])
        end
        @announcement.company = current_user.info.company
        if @announcement.save
            @students = @announcement.subject.students
            @students.each do |s|
                UserMailer.announcement_email(s.email,@announcement.title,@announcement.content).deliver_now
            end
            redirect_to admin_announcement_index_path, notice: "Announcement succesfully created!" 
        else
            flash[:alert] = @announcement.errors.full_messages
            render :new
        end
    end
    def edit
        @announcement = Announcement.find(params[:id])
    end
    def update
        @announcement = Announcement.find(params[:id])

        if @announcement.update_attributes(announcement_params)
            redirect_to admin_announcement_path(@announcement), notice: "Updated Announcement."
        else
            flash[:alert] = @announcement.errors.full_messages
            render :edit
        end
    end
    def destroy
        @announcement = Announcement.find(params[:id])
            if @announcement.delete
                flash[:notice] = 'Announcement deleted!'
                redirect_to admin_announcement_index_path
                
            else
                flash[:alert] = @announcement.errors.full_messages
                render :index
            end
    end

    private

    def announcement_params
        params.require(:announcement).permit( :title, :subject_id, :content)
    end
end
