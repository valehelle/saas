class Announcement < ApplicationRecord
  belongs_to :subject, optional: true
  belongs_to :company
end
