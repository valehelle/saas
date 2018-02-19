class DocumentController < ApplicationController
    before_action :auth_user
    layout "backend_application"
    protect_from_forgery
    def new
        @document = Subject.find(params[:id]).documents.new
        @dashboard_title = 'Documents'
    end
    def create
        @subject = Subject.find(params[:id])
        @document = @subject.documents.new
        @document.doc = params['document']['doc']
        @document.company = current_user.info.company
    
        if @document.save
          flash[:notice] = 'Document uploaded!'
          redirect_to :subject
        else
          flash[:alert] = 'Failed to upload document!'
          render :new
        end
    end
    def download_file
        @document = Document.find(params[:doc_id])
        send_file(@document.doc.file.path,
              :filename => @document.doc.filename,
              :type => @document.doc.file.content_type,
              :disposition => 'attachment',
              :url_based_filename => true)
    end
    def delete_file
        @subject = Subject.find(params[:id])
        @document = @subject.documents.find(params[:doc_id])
        @document.remove_doc!
        @document.save!
        @document.destroy
        redirect_to :subject

    end
end
