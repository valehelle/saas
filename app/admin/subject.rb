ActiveAdmin.register Subject do
    permit_params :teacher_id, :title,:student_ids
    
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  show do
    attributes_table do
      row :title
      row :teacher
    end
    panel 'Students' do
        table_for subject.students do
            column :email
            column do |p| link_to "View", admin_user_path(p.id) 
            end
        end
    end
  end
  form do |f|
    f.inputs do
        f.input :title
        f.input :teacher
        f.input :students, :multiple => true, as: :check_boxes, :collection => User.all.map{ |student|  [student.email, student.id] }
    end
   
    f.actions
  end

  controller do
    def update
        title = params[:subject][:title]
        teacher_id = params[:subject][:user_id]
        teacher = User.find(teacher_id.to_i)

        subject = Subject.find(params[:id])
        subject.teacher = teacher
        subject.title = title
        subject.students.delete_all
        students = params[:subject][:student_ids]
        students.shift
        students.each do |student_id|
            subject.students << User.find(student_id.to_i)
        end
        subject.save!
        redirect_to resource_path(subject)
    end
    def create
        title = params[:subject][:title]
        teacher_id = params[:subject][:user_id]
        teacher = User.find(teacher_id.to_i)

        subject = Subject.new(title: title, teacher: teacher)
        
        students = params[:subject][:student_ids]
        students.shift
        students.each do |student_id|
            subject.students << User.find(student_id.to_i)
        end
        subject.save!
        redirect_to resource_path(subject)
      end
   end

end
