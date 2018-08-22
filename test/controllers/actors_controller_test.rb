require 'test_helper'

class ActorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @crew_member = actors(:one)
  end

  test "should get index" do
    get castMembers_url
    assert_response :success
  end

  test "should get new" do
    get new_castMember_url
    assert_response :success
  end

  test "should create @@crew_member" do
    assert_difference('CrewMember.count') do
      post castMembers_url, params: {crew_member: {  } }
    end

    assert_redirected_to castMember_url(CrewMember.last)
  end

  test "should show @@crew_member" do
    get castMember_url(@crew_member)
    assert_response :success
  end

  test "should get edit" do
    get edit_castMember_url(@crew_member)
    assert_response :success
  end

  test "should update @@crew_member" do
    patch castMember_url(@crew_member), params: {crew_member: {  } }
    assert_redirected_to castMember_url(@crew_member)
  end

  test "should destroy @@crew_member" do
    assert_difference('CrewMember.count', -1) do
      delete castMember_url(@crew_member)
    end

    assert_redirected_to castMembers_url
  end
end
