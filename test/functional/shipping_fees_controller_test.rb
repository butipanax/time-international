require 'test_helper'

class ShippingFeesControllerTest < ActionController::TestCase
  setup do
    @shipping_fee = shipping_fees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shipping_fees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shipping_fee" do
    assert_difference('ShippingFee.count') do
      post :create, :shipping_fee => @shipping_fee.attributes
    end

    assert_redirected_to shipping_fee_path(assigns(:shipping_fee))
  end

  test "should show shipping_fee" do
    get :show, :id => @shipping_fee.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @shipping_fee.to_param
    assert_response :success
  end

  test "should update shipping_fee" do
    put :update, :id => @shipping_fee.to_param, :shipping_fee => @shipping_fee.attributes
    assert_redirected_to shipping_fee_path(assigns(:shipping_fee))
  end

  test "should destroy shipping_fee" do
    assert_difference('ShippingFee.count', -1) do
      delete :destroy, :id => @shipping_fee.to_param
    end

    assert_redirected_to shipping_fees_path
  end
end
