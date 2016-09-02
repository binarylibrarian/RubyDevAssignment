class AddMessagesToEvent < ActiveRecord::Migration
  def change
    add_column :events, :messages, :jsonb
  end
end
