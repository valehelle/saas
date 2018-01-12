class AdminTeacherController < ApplicationController
    before_action :authenticate_user!
    layout "admin_application"
    include AdminUserHelper
    protect_from_forgery
    def index
        @users = User.includes(:info).where(infos: {is_teacher: true})
    end
    def show
        @user = User.find_by_id(params[:id])
    end
    def new
        @user = User.new
    end
    def create
        @user = User.new(user_params)
        # For admin to have its own user without conflict with other admin
        sanitize_email = AdminUserHelper.get_email(@user.email,current_user.info.company.id)
        @user.email = sanitize_email
        if @user.save
            @company =  current_user.info.company
            @info= Info.new(is_admin: false, is_teacher: true, user: @user, company: @company)
            if @info.save
                redirect_to admin_user_index_path, notice: "Teacher succesfully created!" 
            else
                render :new
            end
        else
            render :new
        end
    end
    def edit
        @user = User.find(params[:id])
    end
    def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
            redirect_to user_url, notice: "Updated User."
        else
            render :edit
        end
    end
    def destroy
    end

    private

    def user_params
        params.require(:user).permit( :email, :password, :password_confirmation)
    end

end
