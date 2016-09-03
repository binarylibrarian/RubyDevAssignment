require 'test_helper'

class RoutesTest < ActionDispatch::IntegrationTest
  test "api_route test" do
    assert_generates "/api/v1/events/1/registrants", { :controller => "api/v1/events", :action => "registrants", :id => "1" }
    assert_generates "/api/v1/events/1/messages", { :controller => "api/v1/events", :action => "messages", :id => "1" }
    assert_generates "/api/v1/events/1", { :controller => "api/v1/events", :action => "show", :id => "1" }
    assert_generates "/api/v1/events/", { :controller => "api/v1/events", :action => "index" }
  end
end