require "application_system_test_case"

class CoinRequestsTest < ApplicationSystemTestCase
  setup do
    @coin_request = coin_requests(:one)
  end

  test "visiting the index" do
    visit coin_requests_url
    assert_selector "h1", text: "Coin Requests"
  end

  test "creating a Coin request" do
    visit coin_requests_url
    click_on "New Coin Request"

    fill_in "Coin", with: @coin_request.coin
    fill_in "Price", with: @coin_request.price
    fill_in "Receiver", with: @coin_request.receiver
    fill_in "Sender", with: @coin_request.sender
    fill_in "User", with: @coin_request.user_id
    click_on "Create Coin request"

    assert_text "Coin request was successfully created"
    click_on "Back"
  end

  test "updating a Coin request" do
    visit coin_requests_url
    click_on "Edit", match: :first

    fill_in "Coin", with: @coin_request.coin
    fill_in "Price", with: @coin_request.price
    fill_in "Receiver", with: @coin_request.receiver
    fill_in "Sender", with: @coin_request.sender
    fill_in "User", with: @coin_request.user_id
    click_on "Update Coin request"

    assert_text "Coin request was successfully updated"
    click_on "Back"
  end

  test "destroying a Coin request" do
    visit coin_requests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Coin request was successfully destroyed"
  end
end
