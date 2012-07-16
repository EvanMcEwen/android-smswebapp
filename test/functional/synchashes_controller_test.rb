require 'test_helper'

class SynchashesControllerTest < ActionController::TestCase
  setup do
    @synchash = synchashes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:synchashes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create synchash" do
    assert_difference('Synchash.count') do
      post :create, :synchash => @synchash.attributes
    end

    assert_redirected_to synchash_path(assigns(:synchash))
  end

  test "should show synchash" do
    get :show, :id => @synchash.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @synchash.to_param
    assert_response :success
  end

  test "should update synchash" do
    put :update, :id => @synchash.to_param, :synchash => @synchash.attributes
    assert_redirected_to synchash_path(assigns(:synchash))
  end

  test "should destroy synchash" do
    assert_difference('Synchash.count', -1) do
      delete :destroy, :id => @synchash.to_param
    end

    assert_redirected_to synchashes_path
  end
end
