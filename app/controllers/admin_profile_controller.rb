class AdminProfileController < ApplicationController
    before_action :authenticate_user!
    layout "admin_application"
    protect_from_forgery
    def show
    end
    def edit
        @company = current_user.info.company
    end
    def update
        @company = current_user.info.company
        if @company.update_attributes(profile_params)
            redirect_to admin_profile_path, notice: "Updated Profile."
        else
            flash[:alert] = @company.errors.full_messages
            render :edit
        end 
    end

    private
    def profile_params
        params.require(:company).permit( :title)
    end
end
