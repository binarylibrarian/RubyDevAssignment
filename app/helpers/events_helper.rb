module EventsHelper
  def is_registered?(registrations)
    registrations.any? {|r| r.user == current_user}
  end
end
