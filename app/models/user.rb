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
  def email
    sanitize_email = self[:email]
    if !self[:id].nil?
      user =  User.find(self[:id])
      id = user.info.company.id
      regex = '$$%' + id.to_s 
      email = self[:email]
      e_split = email.split(regex)
      
      if e_split.length > 1
        sanitize_email = e_split.first + e_split.last
      end
    end
    sanitize_email
  end
end
