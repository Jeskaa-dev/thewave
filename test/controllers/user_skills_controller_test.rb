require "test_helper"

class UserSkillsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_skills_index_url
    assert_response :success
  end
end
