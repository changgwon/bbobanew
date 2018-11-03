require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get new2" do
    get home_new2_url
    assert_response :success
  end

  test "should get main" do
    get home_main_url
    assert_response :success
  end

  test "should get fileupload" do
    get home_fileupload_url
    assert_response :success
  end

  test "should get filecreate" do
    get home_filecreate_url
    assert_response :success
  end

  test "should get filehistory" do
    get home_filehistory_url
    assert_response :success
  end

  test "should get filecurrent" do
    get home_filecurrent_url
    assert_response :success
  end

  test "should get ownerpage" do
    get home_ownerpage_url
    assert_response :success
  end

end
