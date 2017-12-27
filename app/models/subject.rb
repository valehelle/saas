class Subject < ApplicationRecord
    has_many :enrolls
    has_many :documents
    has_many :students, through: :enrolls, source: :user
    belongs_to :teacher, class_name: "User", foreign_key: "user_id"
    has_many :announcements

    
end
