require 'test_helper'

class SavingsControllerTest < ActionController::TestCase
  setup do
    @saving = savings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:savings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create saving" do
    assert_difference('Saving.count') do
      post :create, saving: { account_type: @saving.account_type, current_balance: @saving.current_balance, is_active: @saving.is_active, monthly_account_rate: @saving.monthly_account_rate, user_id: @saving.user_id }
    end

    assert_redirected_to saving_path(assigns(:saving))
  end

  test "should show saving" do
    get :show, id: @saving
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @saving
    assert_response :success
  end

  test "should update saving" do
    patch :update, id: @saving, saving: { account_type: @saving.account_type, current_balance: @saving.current_balance, is_active: @saving.is_active, monthly_account_rate: @saving.monthly_account_rate, user_id: @saving.user_id }
    assert_redirected_to saving_path(assigns(:saving))
  end

  test "should destroy saving" do
    assert_difference('Saving.count', -1) do
      delete :destroy, id: @saving
    end

    assert_redirected_to savings_path
  end
end
