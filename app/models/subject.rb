class Subject < ApplicationRecord
    has_many :enrolls, dependent: :destroy
    has_many :documents, dependent: :destroy
    has_many :students, through: :enrolls, source: :user
    belongs_to :teacher, class_name: "User", foreign_key: "user_id"
    has_many :announcements, dependent: :destroy
    belongs_to :company
    
end
