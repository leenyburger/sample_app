require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "invalid signup information" do
  	get signup_path 
    assert_select 'form[action="/signup"]'
  	assert_no_difference 'User.count' do
  		post signup_path, params: {user: {name: "", email: "user@invalid", password: "foo12345", password_confirmation: "bar"}}
  	end
  	assert_template 'users/new'
  	assert_select 'div.alert.alert-danger' #Test for main alert errors
  	assert_select 'div#error_explanation'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count',1 do
      post signup_path, params: {user: {name:"Test Name", email:"email@gmail.com", password:"foo12345", password_confirmation: "foo12345"}}
    end
    follow_redirect!
    assert_template 'users/show'
  end
end
