class AddTopicsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :topics, :jsonb
  end
end
