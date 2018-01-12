class AdminSubjectController < ApplicationController
        before_action :authenticate_user!
    layout "admin_application"
    protect_from_forgery
    def index
        @subjects = Subject.all.paginate(:page => params[:page], :per_page => 10)
    end
    def show
        @subject = Subject.find_by_id(params[:id])
    end
    def new
        @subject = Subject.new
    end
    def create
        @subject = Subject.new(subject_params)
        @subject.teacher = User.find(params[:teacher_id])
        @subject.company = current_user.info.company
        if @subject.save
            redirect_to admin_subject_index_path, notice: "Subject succesfully created!" 
        else
            puts @subject.errors.full_messages
            render :new
        end
    end
    def edit
        @subject = Subject.find(params[:id])
    end
    def update
        @subject = Subject.find(params[:id])
        @subject.teacher = User.find(params[:teacher_id])
        if @subject.update_attributes(subject_params)
            
            @subject.students.delete_all
            students = params[:user][:user_ids]

            students.each do |student_id|
                @subject.students << User.find(student_id.to_i)
            end
            if @subject.save
                redirect_to admin_subject_path(@subject), notice: "Updated Subject."
            else
                render :edit
            end
        else
            render :edit
        end
    end
    def destroy
        @subject = Subject.find(params[:id])
            if @subject.destroy
                flash[:notice] = 'Subject deleted!'
                redirect_to admin_subject_index_path
                
            else
                flash[:error] = 'Failed to delete this subject dele!'
                render :destroy
            end
    end

    private

    def subject_params
        params.require(:subject).permit(:title, :teacher_id, :code)
    end
end
