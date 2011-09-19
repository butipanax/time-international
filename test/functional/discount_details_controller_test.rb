require 'test_helper'

class DiscountDetailsControllerTest < ActionController::TestCase
  setup do
    @discount_detail = discount_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:discount_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create discount_detail" do
    assert_difference('DiscountDetail.count') do
      post :create, :discount_detail => @discount_detail.attributes
    end

    assert_redirected_to discount_detail_path(assigns(:discount_detail))
  end

  test "should show discount_detail" do
    get :show, :id => @discount_detail.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @discount_detail.to_param
    assert_response :success
  end

  test "should update discount_detail" do
    put :update, :id => @discount_detail.to_param, :discount_detail => @discount_detail.attributes
    assert_redirected_to discount_detail_path(assigns(:discount_detail))
  end

  test "should destroy discount_detail" do
    assert_difference('DiscountDetail.count', -1) do
      delete :destroy, :id => @discount_detail.to_param
    end

    assert_redirected_to discount_details_path
  end
end
