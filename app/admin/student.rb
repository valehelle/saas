ActiveAdmin.register Student do
    permit_params :email, :password, :password_confirmation
    
      index do
        selectable_column
        id_column
        column :email
        column :current_sign_in_at
        column :sign_in_count
        column :created_at
        actions
      end
    
      filter :email
      filter :subject_id, :collection => proc { Subject.all }, :as => :select
    
      form do |f|
        f.inputs do
          f.input :email
          f.input :password
          f.input :password_confirmation
        end
        f.actions
      end

end
