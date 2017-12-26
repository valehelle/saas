class Enroll < ApplicationRecord
    belongs_to :student
    belongs_to :subject
    def to_s
        if !self.subject.nil?
          self.subject.title
        end
    end
end
