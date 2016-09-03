require 'elasticsearch/model'

class Event < ActiveRecord::Base

  scope :location, -> (location_name) { where('location @> ?',[location_name].to_json) }
  scope :topics, -> (topic) { where('topics @> ?',[topic].to_json) }

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :user
  has_many :organizer
  has_many :registrations

  after_initialize :init_messages

  def init_messages
    self.messages= []
  end
end

# Commented out to allow for the model to work without Elasticsearch
# Event.import