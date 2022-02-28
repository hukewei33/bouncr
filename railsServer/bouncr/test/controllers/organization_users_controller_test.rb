require "test_helper"

class OrganizationUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization_user = organization_users(:one)
  end

  test "should get index" do
    get organization_users_url, as: :json
    assert_response :success
  end

  test "should create organization_user" do
    assert_difference('OrganizationUser.count') do
      post organization_users_url, params: { organization_user: { isAdmin: @organization_user.isAdmin, organization_id: @organization_user.organization_id, user_id: @organization_user.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show organization_user" do
    get organization_user_url(@organization_user), as: :json
    assert_response :success
  end

  test "should update organization_user" do
    patch organization_user_url(@organization_user), params: { organization_user: { isAdmin: @organization_user.isAdmin, organization_id: @organization_user.organization_id, user_id: @organization_user.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy organization_user" do
    assert_difference('OrganizationUser.count', -1) do
      delete organization_user_url(@organization_user), as: :json
    end

    assert_response 204
  end
end
