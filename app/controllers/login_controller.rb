class LoginController < ApplicationController
    protect_from_forgery
    def admin_register
        @user = User.new
        @user.build_info
    end
    def admin_create
        @user = User.new(user_params)
        if @user.save
            @company = Company.new(title: params[:user][:company],user: @user)
            if @company.save
                @info = Info.new(is_admin: true, is_teacher: true,company: @company, user: @user)
                if @info.save
                    sign_in(@user, scope: :user)
                    redirect_to admin_profile_path, notice: "Welcome!" 
                else
                    flash[:alert] = @user.errors.full_messages
                    @user.delete
                    render :admin_register                
                end
            else
                flash[:alert] = @user.errors.full_messages
                @user.delete
                render :admin_register
            end
        else
            flash[:alert] = @user.errors.full_messages
            render :admin_register
        end
    end
    def user_login
        @user = User.new
        if Company.where(id: request.subdomain.to_s).exists?
            @company = Company.find_by(id: request.subdomain.to_s)
            render layout: "login_application"
        else
            redirect_to root_path
        end
    end
    def user_sign_out
        sign_out current_user
        redirect_to login_url(:domain => request.domain)
    end
    def user_sign_in
        email = get_email(request.subdomain.to_s, params[:user][:email])
        @user = User.find_by_email(email)
        if !@user.nil? && @user.valid_password?(params[:user][:password])
            sign_in(@user, scope: :user)
            redirect_to dashboard_path() 
        else
            @user = User.find_by_email(params[:user][:email])
            puts @user.info.company.id
            puts request.domain.to_s
            if !@user.nil? && @user.valid_password?(params[:user][:password]) && @user.info.company.id.to_s == request.subdomain.to_s
                sign_in(@user, scope: :user)
                redirect_to dashboard_path()         
            else
                flash[:alert] =  "Incorrect email or password"
                @user = User.new
                @company = Company.find_by(id: request.subdomain)
                render :user_login, layout: "login_application"
            end
        end
    end
    private
    def get_email(company_id, email)
        s_email = email.split('@')
        new_email = s_email.first + '$$%' + company_id.to_s + '@' + s_email.last
    end
    def user_params
        params.require(:user).permit( :email, :password, :password_confirmation, {:info_attributes => [:is_teacher, :is_admin]})
    end
end
