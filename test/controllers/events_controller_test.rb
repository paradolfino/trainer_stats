require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  test "should get audit" do
    get events_audit_url
    assert_response :success
  end

end
