require "test_helper"

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: "sports")
    @category2 = Category.create(name: "travel")
    sign_in_as(
      User.create(
        username: "mohamed",
        email: "mohamed@example.com",
        password: "123"
      )
    )
  end

  test "get category show and index pages" do
    get categories_path
    assert_select "a[href=?]", category_path(@category), text: @category.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name
  end
end
