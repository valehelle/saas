ActiveAdmin.register User do
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
      row :email
      row :current_sign_in_at
    end
    panel 'Info' do
        table_for user.info do
            column :is_teacher
        end
    end
  end
index do
    selectable_column
    id_column
    column :email
    column "Is a teacher" do |user|
        user.info.is_teacher
    end
    column :created_at
    actions
  end

  filter :email
  filter :info_is_teacher, as: :select, collection: [["Yes", true], ["No", false]], label: 'Is a teacher'
  
  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.inputs "", for: [:info, f.object.info || Info.new] do |p|
        p.input :is_teacher
      end

      
    end
    f.actions
  end
  permit_params :email, :password, :password_confirmation,
  info_attributes: [ :is_teacher  ]
end
