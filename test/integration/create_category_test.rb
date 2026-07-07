require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  def setup
    sign_in_as(
      User.create(
        username: "mohamed",
        email: "mohamed@example.com",
        password: "123",
        admin: true
      )
    )
  end

  test "Get the new category forms and create the category" do
    get new_category_path
    assert_response :success
    assert_difference "Category.count", 1 do
      post categories_path, params: { category: { name: "sports" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "sports", response.body
  end

  test "invalid category submission results in failure" do
    get new_category_path
    assert_response :success
    assert_no_difference "Category.count" do
      post categories_path, params: { category: { name: "" } }
      assert_response :unprocessable_entity
    end
  end
end
