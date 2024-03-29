class User < ActiveRecord::Base
  has_many :organizers
  has_many :registrations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def full_name
    self.first_name << ' ' << self.last_name
  end
end
