require 'test_helper'

class EventTest < ActiveSupport::TestCase

  # Search test

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

  # Messages and multiuser tests

  test "event should have messages from user" do
    result = Event.where('messages @> ?', '[{"user_id":1}]')
    assert result.count > 0
  end

  test "event should have multiple organizers" do
    e = Event.first
    assert e.organizer.count > 1
  end

  # Filter test

  test "events filtered by location should be fewer then total events" do
    total = Event.all.count
    toronto_total = Event.location("Toronto").count
    assert total > toronto_total
  end

  test "events filtered by location should have that location" do
    assert Event.location("Toronto").include?("Toronto")

  end

  test "events filtered by topic should be less then total" do
    total = Event.all.count
    music_total = Event.topics("music").count
    assert total > music_total
  end

  test "event filtered by topic should contain that topic" do
    assert Event.topics("music").first.topics.include?("music")
  end

  test "events filtered by date should be fewer then total" do
    total = Event.all.count
    starttime = '2016-08-31'.to_datetime
    endtime = '2016-09-10'.to_datetime
    assert total > Event.where(start_at: starttime...endtime)
  end

end
