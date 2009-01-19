require 'test_helper'

class Admin::ImagesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create image" do
    assert_difference('Admin::Image.count') do
      post :create, :image => { }
    end

    assert_redirected_to image_path(assigns(:image))
  end

  test "should show image" do
    get :show, :id => admin_images(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => admin_images(:one).id
    assert_response :success
  end

  test "should update image" do
    put :update, :id => admin_images(:one).id, :image => { }
    assert_redirected_to image_path(assigns(:image))
  end

  test "should destroy image" do
    assert_difference('Admin::Image.count', -1) do
      delete :destroy, :id => admin_images(:one).id
    end

    assert_redirected_to admin_images_path
  end
end
