class DashboardController < ApplicationController
    def index
        @announcement = Announcement.all()
    end
end
