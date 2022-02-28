require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get events_url, as: :json
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post events_url, params: { event: { attendenceCap: @event.attendenceCap, attendenceVisible: @event.attendenceVisible, city: @event.city, coverCharge: @event.coverCharge, description: @event.description, endTime: @event.endTime, friendsAttendingVisible: @event.friendsAttendingVisible, isOpenInvite: @event.isOpenInvite, name: @event.name, startTime: @event.startTime, street1: @event.street1, street2: @event.street2, venueLatitude: @event.venueLatitude, venueLongitude: @event.venueLongitude, zip: @event.zip } }, as: :json
    end

    assert_response 201
  end

  test "should show event" do
    get event_url(@event), as: :json
    assert_response :success
  end

  test "should update event" do
    patch event_url(@event), params: { event: { attendenceCap: @event.attendenceCap, attendenceVisible: @event.attendenceVisible, city: @event.city, coverCharge: @event.coverCharge, description: @event.description, endTime: @event.endTime, friendsAttendingVisible: @event.friendsAttendingVisible, isOpenInvite: @event.isOpenInvite, name: @event.name, startTime: @event.startTime, street1: @event.street1, street2: @event.street2, venueLatitude: @event.venueLatitude, venueLongitude: @event.venueLongitude, zip: @event.zip } }, as: :json
    assert_response 200
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete event_url(@event), as: :json
    end

    assert_response 204
  end
end
