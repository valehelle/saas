class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :enrolls
  has_many :subjects, through: :enrolls
  has_many :teaches, class_name: "Subject"
  has_one :info
end
