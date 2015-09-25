require 'test_helper'

class UserTest < ActiveSupport::TestCase
    def setup
        @user = User.new(
            name: "Example User",
            email: "user@example.com",
            password: "foo",
            password_confirmation: "foo")
    end

    test "should be valid" do
        assert @user.valid?
    end

    test "name should be present" do
        @user.name = "      "
        assert_not @user.valid?
    end

    test "email should be present" do
        @user.email = "     "
        assert_not @user.valid?
    end

    test "name should not be too long" do
        @user.name = 'a'*101
        assert_not @user.valid?
    end

    test "name should not be too short" do
        @user.name = 'a'
        assert_not @user.valid?
    end

    test "email should not be too long" do
        @user.email = 'a'*244 + '@example.com'
        assert_not @user.valid?
    end

    test "email should be sane" do
        # This test just ensures that an @ sign is in the email address. RFC 5321 is very permissive, and I
        # don't want to bother.
        @user.email = 'manlymanatexample.com'
        assert_not @user.valid?
    end

    test "email should be unique" do
        dup_user = @user.dup
        dup_user.email = @user.email.upcase
        @user.save
        assert_not dup_user.valid?
    end
end
