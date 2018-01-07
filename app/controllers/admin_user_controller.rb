class AdminUserController < ApplicationController
    before_action :authenticate_user!
    layout "admin_application"
    protect_from_forgery
    def index
        @users = User.includes(:info).where(infos: {is_admin: true})
    end
    def show
        @user = User.find_by_id(params[:id])
    end
    def new
        @user = User.new
        @user.build_info
    end
    def create
        @user = User.new(user_params)
        @user.info.is_admin = true
        if @user.save
            redirect_to admin_user_index_path, notice: "Admin succesfully created!" 
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
            redirect_to admin_user_path(@user), notice: "Updated User."
        else
            render :edit
        end
    end
    def destroy
    end

    private

    def user_params
        params.require(:user).permit( :email, :password, :password_confirmation, {:info_attributes => [:is_teacher, :is_admin]})
    end
end