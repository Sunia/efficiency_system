require 'test_helper'

class OperatingConditionsControllerTest < ActionController::TestCase
  setup do
    @operating_condition = operating_conditions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:operating_conditions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create operating_condition" do
    assert_difference('OperatingCondition.count') do
      post :create, operating_condition: {  }
    end

    assert_redirected_to operating_condition_path(assigns(:operating_condition))
  end

  test "should show operating_condition" do
    get :show, id: @operating_condition
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @operating_condition
    assert_response :success
  end

  test "should update operating_condition" do
    patch :update, id: @operating_condition, operating_condition: {  }
    assert_redirected_to operating_condition_path(assigns(:operating_condition))
  end

  test "should destroy operating_condition" do
    assert_difference('OperatingCondition.count', -1) do
      delete :destroy, id: @operating_condition
    end

    assert_redirected_to operating_conditions_path
  end
end
