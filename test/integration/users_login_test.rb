require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "login should reject gracefully" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: {email: "nope", password: "still nope"}
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
end
