class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def after_sign_in_path_for(resource)
    if resource.class == User
      admin_user_index_path
    elsif resource.class == AdminUser
      admin_root_path
    end
  end
end
