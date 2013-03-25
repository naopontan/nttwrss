require 'test_helper'

class MyRequestsControllerTest < ActionController::TestCase
  setup do
    @my_request = my_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:my_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create my_request" do
    assert_difference('MyRequest.count') do
      post :create, my_request: { url: @my_request.url }
    end

    assert_redirected_to my_request_path(assigns(:my_request))
  end

  test "should show my_request" do
    get :show, id: @my_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @my_request
    assert_response :success
  end

  test "should update my_request" do
    put :update, id: @my_request, my_request: { url: @my_request.url }
    assert_redirected_to my_request_path(assigns(:my_request))
  end

  test "should destroy my_request" do
    assert_difference('MyRequest.count', -1) do
      delete :destroy, id: @my_request
    end

    assert_redirected_to my_requests_path
  end
end
