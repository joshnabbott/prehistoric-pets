require 'test_helper'

class Admin::ShippingCategoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_shipping_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shipping_category" do
    assert_difference('Admin::ShippingCategory.count') do
      post :create, :shipping_category => { }
    end

    assert_redirected_to shipping_category_path(assigns(:shipping_category))
  end

  test "should show shipping_category" do
    get :show, :id => admin_shipping_categories(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => admin_shipping_categories(:one).to_param
    assert_response :success
  end

  test "should update shipping_category" do
    put :update, :id => admin_shipping_categories(:one).to_param, :shipping_category => { }
    assert_redirected_to shipping_category_path(assigns(:shipping_category))
  end

  test "should destroy shipping_category" do
    assert_difference('Admin::ShippingCategory.count', -1) do
      delete :destroy, :id => admin_shipping_categories(:one).to_param
    end

    assert_redirected_to admin_shipping_categories_path
  end
end
