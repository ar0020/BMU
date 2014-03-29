require 'test_helper'

class BillsControllerTest < ActionController::TestCase
  setup do
    @bill = bills(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bills)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bill" do
    assert_difference('Bill.count') do
      post :create, bill: { account_id: @bill.account_id, amount: @bill.amount, is_recurring: @bill.is_recurring, pay_date: @bill.pay_date, payee_account_id: @bill.payee_account_id, payee_city: @bill.payee_city, payee_name: @bill.payee_name, payee_state: @bill.payee_state, payee_street: @bill.payee_street, payee_zip: @bill.payee_zip, user_id: @bill.user_id }
    end

    assert_redirected_to bill_path(assigns(:bill))
  end

  test "should show bill" do
    get :show, id: @bill
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bill
    assert_response :success
  end

  test "should update bill" do
    patch :update, id: @bill, bill: { account_id: @bill.account_id, amount: @bill.amount, is_recurring: @bill.is_recurring, pay_date: @bill.pay_date, payee_account_id: @bill.payee_account_id, payee_city: @bill.payee_city, payee_name: @bill.payee_name, payee_state: @bill.payee_state, payee_street: @bill.payee_street, payee_zip: @bill.payee_zip, user_id: @bill.user_id }
    assert_redirected_to bill_path(assigns(:bill))
  end

  test "should destroy bill" do
    assert_difference('Bill.count', -1) do
      delete :destroy, id: @bill
    end

    assert_redirected_to bills_path
  end
end
