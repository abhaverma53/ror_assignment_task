require "test_helper"

class ImportSheetControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get import_sheet_show_url
    assert_response :success
  end
end
