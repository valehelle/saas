class FrontController < ApplicationController
    def index
        @documents = Subject.last.documents.new
    end
    def new
    end
    def create
        @document = Subject.last.documents.new()
        @document.doc = params['document']['doc']
        puts 'helooo'
        @document.save
    end
end
