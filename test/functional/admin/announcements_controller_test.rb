require 'test_helper'

class Admin::AnnouncementsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_announcements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create announcement" do
    assert_difference('Admin::Announcement.count') do
      post :create, :announcement => { }
    end

    assert_redirected_to announcement_path(assigns(:announcement))
  end

  test "should show announcement" do
    get :show, :id => admin_announcements(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => admin_announcements(:one).id
    assert_response :success
  end

  test "should update announcement" do
    put :update, :id => admin_announcements(:one).id, :announcement => { }
    assert_redirected_to announcement_path(assigns(:announcement))
  end

  test "should destroy announcement" do
    assert_difference('Admin::Announcement.count', -1) do
      delete :destroy, :id => admin_announcements(:one).id
    end

    assert_redirected_to admin_announcements_path
  end
end
