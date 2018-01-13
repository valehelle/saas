class AdminTeacherController < ApplicationController
    before_action :authenticate_user!
    layout "admin_application"
    include AdminUserHelper
    protect_from_forgery
    def index
        @users = User.includes(:info).where(infos: {is_teacher: true}).paginate(:page => params[:page], :per_page => 10)
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
        original_email = @user.email
        unsanitize_email = @user.get_unsanitize_email(params[:user][:email],current_user.info.company.id)
        @user.email = unsanitize_email
        if @user.save
            @company =  current_user.info.company
            @info= Info.new(is_admin: false, is_teacher: true, user: @user, company: @company)
            if @info.save
                redirect_to admin_teacher_index_path, notice: "Teacher succesfully created!" 
            else
                @user.email = original_email
                render :new
            end
        else
            @user.email = original_email
            render :new
        end
    end
    def edit
        @user = User.find(params[:id])
    end
    def update
        @user = User.find(params[:id])
        original_email = @user.email
        unsanitize_email = @user.get_unsanitize_email(params[:user][:email],current_user.info.company.id)

        if !@user.info.is_admin
            if @user.update_attributes(user_params)
                if !User.exists?(email: unsanitize_email)
                    @user.email = unsanitize_email
                else
                    @user.email = original_email
                end
                if @user.save
                    redirect_to admin_teacher_path(@user), notice: "Updated User."
                else
                    render :edit
                end
            else
                render :edit
            end        
        else
            redirect_to admin_teacher_path(@user), notice: "This user is an admin. Please update in the admin tab."
        end

    end
    def destroy
        @user = User.find(params[:id])
        if @user.info.is_admin == false && @user.delete
            flash[:notice] = 'User deleted!'
            redirect_to admin_teacher_index_path
            
        else
            flash[:error] = 'Failed to delete this user!'
            redirect_to admin_teacher_index_path
        end
    end

    private

    def user_params
        params.require(:user).permit( :email, :password, :password_confirmation)
    end

end
