class SubjectController < ApplicationController
    before_action :authenticate_user!
    layout "backend_application"
    protect_from_forgery
    def index
       
    end
    def show
    end
end
