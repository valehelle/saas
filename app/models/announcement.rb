class Announcement < ApplicationRecord
  belongs_to :subject, optional: true
end
