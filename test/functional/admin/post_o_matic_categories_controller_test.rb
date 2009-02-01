require 'test_helper'

class Admin::PostOMaticCategoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_post_o_matic_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create post_o_matic_category" do
    assert_difference('Admin::PostOMaticCategory.count') do
      post :create, :post_o_matic_category => { }
    end

    assert_redirected_to post_o_matic_category_path(assigns(:post_o_matic_category))
  end

  test "should show post_o_matic_category" do
    get :show, :id => admin_post_o_matic_categories(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => admin_post_o_matic_categories(:one).id
    assert_response :success
  end

  test "should update post_o_matic_category" do
    put :update, :id => admin_post_o_matic_categories(:one).id, :post_o_matic_category => { }
    assert_redirected_to post_o_matic_category_path(assigns(:post_o_matic_category))
  end

  test "should destroy post_o_matic_category" do
    assert_difference('Admin::PostOMaticCategory.count', -1) do
      delete :destroy, :id => admin_post_o_matic_categories(:one).id
    end

    assert_redirected_to admin_post_o_matic_categories_path
  end
end
