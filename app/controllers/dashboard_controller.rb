class DashboardController < ApplicationController
    before_action :authenticate_user!
    layout "backend_application"
    def index
        @announcements = Announcement.last(5).reverse
    end
end
