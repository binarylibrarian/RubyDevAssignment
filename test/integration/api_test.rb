require 'test_helper'

class RoutesTest < ActionDispatch::IntegrationTest
  test "events returns all events" do
    get '/api/v1/events'
    body = JSON.parse(response.body)
    assert body['events'].count == 3
  end

  test "event with id returns single event" do
    get '/api/v1/events/1'
    body = JSON.parse(response.body)
    assert body['events'].count == 1
  end

  test "events/:id/messages returns messages" do
    get '/api/v1/events'
    body = JSON.parse(response.body)
    assert body['msg'].count < 0
  end

  test "events/:id/messages returns messages but nothing else" do
    get '/api/v1/events'
    body = JSON.parse(response.body)
    assert !body.key?("events")
  end

  test "events/:id/registrants returns messages" do
    get '/api/v1/events'
    body = JSON.parse(response.body)
    assert body['registrants'].count < 0
  end

  test "events/:id/registrants returns registrants but nothing else" do
    get '/api/v1/events'
    body = JSON.parse(response.body)
    assert !body.key?("events")
  end
end