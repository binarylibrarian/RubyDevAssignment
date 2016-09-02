class Event < ActiveRecord::Base
  belongs_to :user
  has_many :organizers
  after_initialize :init_messages

  def init_messages
    self.messages= []
  end
end
