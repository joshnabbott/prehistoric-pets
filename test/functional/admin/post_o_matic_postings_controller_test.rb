require 'test_helper'

class Admin::PostOMaticPostingsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_post_o_matic_postings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create post_o_matic_posting" do
    assert_difference('Admin::PostOMaticPosting.count') do
      post :create, :post_o_matic_posting => { }
    end

    assert_redirected_to post_o_matic_posting_path(assigns(:post_o_matic_posting))
  end

  test "should show post_o_matic_posting" do
    get :show, :id => admin_post_o_matic_postings(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => admin_post_o_matic_postings(:one).id
    assert_response :success
  end

  test "should update post_o_matic_posting" do
    put :update, :id => admin_post_o_matic_postings(:one).id, :post_o_matic_posting => { }
    assert_redirected_to post_o_matic_posting_path(assigns(:post_o_matic_posting))
  end

  test "should destroy post_o_matic_posting" do
    assert_difference('Admin::PostOMaticPosting.count', -1) do
      delete :destroy, :id => admin_post_o_matic_postings(:one).id
    end

    assert_redirected_to admin_post_o_matic_postings_path
  end
end
