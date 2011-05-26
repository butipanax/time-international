require 'test_helper'

class BonusUpgradeDetailsControllerTest < ActionController::TestCase
  setup do
    @bonus_upgrade_detail = bonus_upgrade_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bonus_upgrade_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bonus_upgrade_detail" do
    assert_difference('BonusUpgradeDetail.count') do
      post :create, :bonus_upgrade_detail => @bonus_upgrade_detail.attributes
    end

    assert_redirected_to bonus_upgrade_detail_path(assigns(:bonus_upgrade_detail))
  end

  test "should show bonus_upgrade_detail" do
    get :show, :id => @bonus_upgrade_detail.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @bonus_upgrade_detail.to_param
    assert_response :success
  end

  test "should update bonus_upgrade_detail" do
    put :update, :id => @bonus_upgrade_detail.to_param, :bonus_upgrade_detail => @bonus_upgrade_detail.attributes
    assert_redirected_to bonus_upgrade_detail_path(assigns(:bonus_upgrade_detail))
  end

  test "should destroy bonus_upgrade_detail" do
    assert_difference('BonusUpgradeDetail.count', -1) do
      delete :destroy, :id => @bonus_upgrade_detail.to_param
    end

    assert_redirected_to bonus_upgrade_details_path
  end
end
