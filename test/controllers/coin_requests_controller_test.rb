require "test_helper"

class CoinRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @coin_request = coin_requests(:one)
  end

  test "should get index" do
    get coin_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_coin_request_url
    assert_response :success
  end

  test "should create coin_request" do
    assert_difference('CoinRequest.count') do
      post coin_requests_url, params: { coin_request: { coin: @coin_request.coin, price: @coin_request.price, receiver: @coin_request.receiver, sender: @coin_request.sender, user_id: @coin_request.user_id } }
    end

    assert_redirected_to coin_request_url(CoinRequest.last)
  end

  test "should show coin_request" do
    get coin_request_url(@coin_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_coin_request_url(@coin_request)
    assert_response :success
  end

  test "should update coin_request" do
    patch coin_request_url(@coin_request), params: { coin_request: { coin: @coin_request.coin, price: @coin_request.price, receiver: @coin_request.receiver, sender: @coin_request.sender, user_id: @coin_request.user_id } }
    assert_redirected_to coin_request_url(@coin_request)
  end

  test "should destroy coin_request" do
    assert_difference('CoinRequest.count', -1) do
      delete coin_request_url(@coin_request)
    end

    assert_redirected_to coin_requests_url
  end
end
