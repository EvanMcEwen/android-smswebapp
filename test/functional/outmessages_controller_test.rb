require 'test_helper'

class OutmessagesControllerTest < ActionController::TestCase
  setup do
    @outmessage = outmessages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outmessages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outmessage" do
    assert_difference('Outmessage.count') do
      post :create, :outmessage => @outmessage.attributes
    end

    assert_redirected_to outmessage_path(assigns(:outmessage))
  end

  test "should show outmessage" do
    get :show, :id => @outmessage.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @outmessage.to_param
    assert_response :success
  end

  test "should update outmessage" do
    put :update, :id => @outmessage.to_param, :outmessage => @outmessage.attributes
    assert_redirected_to outmessage_path(assigns(:outmessage))
  end

  test "should destroy outmessage" do
    assert_difference('Outmessage.count', -1) do
      delete :destroy, :id => @outmessage.to_param
    end

    assert_redirected_to outmessages_path
  end
end
