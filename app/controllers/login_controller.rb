class LoginController < ApplicationController
    protect_from_forgery
    def admin_login
    
    end
    def user_login
        @user = User.new
    end
    def user_sign_in
        email = get_email(params[:company_id], params[:user][:email])
        user = User.find_by_email(email)
        if !user.nil? && user.valid_password?(params[:user][:password])
            sign_in(user, scope: :user)
            redirect_to dashboard_path() 
        else
            @user = User.new
            render :user_login
        end
    end
    private
    def get_email(company_id, email)
        s_email = email.split('@')
        new_email = s_email.first + '$$%' + company_id.to_s + '@' + s_email.last
    end
end
