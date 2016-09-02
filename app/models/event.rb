class Event < ActiveRecord::Base
  belongs_to :user
  after_initialize :init_messages

  def init_messages
    self.messages= []
  end
end
