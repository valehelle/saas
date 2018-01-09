class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :enrolls
  has_many :subjects, through: :enrolls
  has_many :teaches, class_name: "Subject"
  has_one :info
  has_one :company
  accepts_nested_attributes_for :info, :allow_destroy => true
  def to_s
    self.email
  end
end
