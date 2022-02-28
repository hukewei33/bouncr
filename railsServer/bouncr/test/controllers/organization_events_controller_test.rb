require "test_helper"

class OrganizationEventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization_event = organization_events(:one)
  end

  test "should get index" do
    get organization_events_url, as: :json
    assert_response :success
  end

  test "should create organization_event" do
    assert_difference('OrganizationEvent.count') do
      post organization_events_url, params: { organization_event: { event_id: @organization_event.event_id, organization_id: @organization_event.organization_id } }, as: :json
    end

    assert_response 201
  end

  test "should show organization_event" do
    get organization_event_url(@organization_event), as: :json
    assert_response :success
  end

  test "should update organization_event" do
    patch organization_event_url(@organization_event), params: { organization_event: { event_id: @organization_event.event_id, organization_id: @organization_event.organization_id } }, as: :json
    assert_response 200
  end

  test "should destroy organization_event" do
    assert_difference('OrganizationEvent.count', -1) do
      delete organization_event_url(@organization_event), as: :json
    end

    assert_response 204
  end
end
