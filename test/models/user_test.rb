require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup #setup automatically gets run before each test 
		@user = User.new(name: "Example User", email: "user@example.com", 
			password: "foobar", password_confirmation: "foobar")
	end

	test "should be valid" do
		assert @user.valid?
	end

	test "name should be present" do
		@user.name = "	"
		assert_not @user.valid?
	end

	test "email should be present" do
		@user.email=" "
		assert_not @user.valid?
	end 

	test "name should not be too long" do
		@user.name = "a"*51				#How does this sub in created user?  Won't it always use the user in setup?  Where am I comparing this to the user that was entered?
		assert_not @user.valid?		#I think this is just testing the validation
	end

	test "email should not be too long" do
		@user.email = "a" *244 + "@example.com" #making the email too long
		assert_not @user.valid?					#@user.valid is true w/o validation in model, so this test fails.  Will pass is user.valid? is not true 
	end 

	test "email validation should accept valid addresses" do
		valid_addresses = %w[user@example.com USER@food.COM A_US-ER@foo.bar.org first.last@foo.jp alic+bob@bax.cn]
		valid_addresses.each do |valid_address|
			@user.email = valid_address
			assert @user.valid?, "#{valid_address.inspect} should be valid"
		end
	end

	test "email validation should reject invalid addresses" do
		invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_bax.com foo@bar+baz.com]
		invalid_addresses.each do |invalid_address|
			@user.email = invalid_address
			assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
		end
	end

	test "email address should be unique" do
		duplicate_user = @user.dup
		duplicate_user.email = @user.email.upcase
		@user.save
		assert_not duplicate_user.valid?
	end

	test "email addresses should be saved as lower-case" do
		mixed_case_email = "Foo@ExAMPLe.com"
		@user.email = mixed_case_email
		@user.save
		assert_equal mixed_case_email.downcase, @user.reload.email 
	end 

	test "password should be present (nonblank)" do 
		@user.password = @user.password_confirmation = " "*6
		assert_not @user.valid?
	end

	test "password should have a minimum length" do
		@user.password = @user.password_confirmation ="a"*5
		assert_not @user.valid?
	end

end
