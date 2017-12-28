class DashboardController < ApplicationController
    before_action :authenticate_user!
    layout "backend_application"
    def index
        @announcement = Announcement.all()
    end
end
