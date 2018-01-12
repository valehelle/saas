class AdminStudentController < ApplicationController
    before_action :authenticate_user!
    layout "admin_application"
    include AdminUserHelper
    protect_from_forgery
    def index
        @users = User.includes(:info).where(infos: {is_admin: false, is_teacher: false}).paginate(:page => params[:page], :per_page => 10)
    end
    def show
        @user = User.find_by_id(params[:id])
    end
    def new
        @user = User.new
    end
    def create
        @user = User.new(user_params)
        @user.email = @user.get_unsanitize_email(params[:user][:email],current_user.info.company.id)
        if @user.save
            @company = current_user.info.company
            @info= Info.new(is_admin: false, is_teacher: false, user: @user, company: @company)
            
            if @info.save
                redirect_to admin_student_path(@user), notice: "Student succesfully created!" 
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
        original_email = @user.email
        unsanitize_email = @user.get_unsanitize_email(params[:user][:email],current_user.info.company.id)

        if @user.update_attributes(user_params)
            if !User.exists?(email: unsanitize_email)
                @user.email = unsanitize_email
            else
                @user.email = original_email
            end
            @user.subjects.delete_all
            
            if !params[:subject].nil?
                subjects = params[:subject][:subject_ids]
                subjects.each do |subject_id|
                    @user.subjects << Subject.find(subject_id.to_i)
                end
            end
            if @user.save
                redirect_to admin_student_path(@user), notice: "Updated User."
            else
                render :edit
            end
        else
            render :edit
        end
    end
    def destroy
        @user = User.find(params[:id])
            if @user.delete
                flash[:notice] = 'User deleted!'
                redirect_to admin_user_index_path
                
            else
                flash[:error] = 'Failed to delete this announcement!'
                render :destroy
            end
    end

    private

    def user_params
        params.require(:user).permit( :email, :password, :password_confirmation, {:info_attributes => [:is_teacher, :is_admin]}, {:subject => [:id]})
    end
end
