class Company < ApplicationRecord
  belongs_to :user
  has_many :subject
  has_many :info
end
