require 'test_helper'

class Admin::CaresheetsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_caresheets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create caresheet" do
    assert_difference('Admin::Caresheet.count') do
      post :create, :caresheet => { }
    end

    assert_redirected_to caresheet_path(assigns(:caresheet))
  end

  test "should show caresheet" do
    get :show, :id => admin_caresheets(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => admin_caresheets(:one).id
    assert_response :success
  end

  test "should update caresheet" do
    put :update, :id => admin_caresheets(:one).id, :caresheet => { }
    assert_redirected_to caresheet_path(assigns(:caresheet))
  end

  test "should destroy caresheet" do
    assert_difference('Admin::Caresheet.count', -1) do
      delete :destroy, :id => admin_caresheets(:one).id
    end

    assert_redirected_to admin_caresheets_path
  end
end
