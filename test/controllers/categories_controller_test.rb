require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: "sports")
    @admin_user =
      User.create(
        username: "mohamed",
        email: "mohamed@example.com",
        admin: true,
        password: "123"
      )
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@admin_user)
    get new_category_url
    assert_response :success
  end

  test "should create category" do
    sign_in_as(@admin_user)
    assert_difference("Category.count", 1) do
      post categories_url, params: { category: { name: "travel" } }
    end

    assert_redirected_to category_url(Category.last)
  end

  test "shouldn't create category if user is not admin." do
    assert_no_difference "Category.count" do
      post categories_path, params: { category: { name: "sports" } }
    end
    assert_redirected_to categories_path
  end

  test "should show category" do
    get category_url(@category)
    assert_response :success
  end
end
