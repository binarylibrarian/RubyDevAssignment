require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "search should return a elasticsearch resuts" do
    result = Event.search 'music'
    assert_not_nil result
  end

  test "search should return resuts" do
    begin
      result = Event.search 'music'
      assert result.count > 0
    rescue
      assert false, "Could not connect to Elasticsearch"
    end
  end

  test "event should have messages from user" do
    result = Event.where('messages @> ?', '[{"user_id":1}]')
    assert result.count > 0
  end

  test "event should have multiple organizers" do
    e = Event.first
    assert e.organizer.count > 1
  end

end
