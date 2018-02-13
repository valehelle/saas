class DashboardController < ApplicationController
    before_action :authenticate_user!
    layout "backend_application"
    def index
        @announcements = Announcement.where(company_id: current_user.info.company_id).last(5).reverse
        if current_user.info.is_teacher then
            @subjects = current_user.teaches
        else
            @subjects = current_user.subjects
        end
        @dashboard_title = 'Dashboard'
    end
end
