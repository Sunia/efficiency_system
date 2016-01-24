require 'test_helper'

class WeatherDistancesControllerTest < ActionController::TestCase
  setup do
    @weather_distance = weather_distances(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weather_distances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create weather_distance" do
    assert_difference('WeatherDistance.count') do
      post :create, weather_distance: {  }
    end

    assert_redirected_to weather_distance_path(assigns(:weather_distance))
  end

  test "should show weather_distance" do
    get :show, id: @weather_distance
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @weather_distance
    assert_response :success
  end

  test "should update weather_distance" do
    patch :update, id: @weather_distance, weather_distance: {  }
    assert_redirected_to weather_distance_path(assigns(:weather_distance))
  end

  test "should destroy weather_distance" do
    assert_difference('WeatherDistance.count', -1) do
      delete :destroy, id: @weather_distance
    end

    assert_redirected_to weather_distances_path
  end
end
