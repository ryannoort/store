require 'test_helper'

class MetadataSetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @metadata_set = metadata_sets(:one)
  end

  test "should get index" do
    get metadata_sets_url
    assert_response :success
  end

  test "should get new" do
    get new_metadata_set_url
    assert_response :success
  end

  test "should create metadata_set" do
    assert_difference('MetadataSet.count') do
      post metadata_sets_url, params: { metadata_set: {  } }
    end

    assert_redirected_to metadata_set_url(MetadataSet.last)
  end

  test "should show metadata_set" do
    get metadata_set_url(@metadata_set)
    assert_response :success
  end

  test "should get edit" do
    get edit_metadata_set_url(@metadata_set)
    assert_response :success
  end

  test "should update metadata_set" do
    patch metadata_set_url(@metadata_set), params: { metadata_set: {  } }
    assert_redirected_to metadata_set_url(@metadata_set)
  end

  test "should destroy metadata_set" do
    assert_difference('MetadataSet.count', -1) do
      delete metadata_set_url(@metadata_set)
    end

    assert_redirected_to metadata_sets_url
  end
end
