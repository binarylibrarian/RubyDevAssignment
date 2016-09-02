require 'elasticsearch/model'

class Event < ActiveRecord::Base
  include Filterable

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :user
  has_many :organizer
  after_initialize :init_messages

  def init_messages
    self.messages= []
  end
end

# Commented out to allow for the model to work without Elasticsearch
# Event.import