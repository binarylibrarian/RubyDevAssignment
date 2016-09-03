require 'test_helper'

class RegistrationTest < ActiveSupport::TestCase
  test "user can be resgistered for an event" do
    user = User.first
    event = Event.first

    initial_registration_count = event.registrations.count

    @registration = Registration.new(user:user,event:event, name:user.full_name)
    @registration.save

    assert initial_registration_count < event.registrations.count
  end
end
