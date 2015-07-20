Given /^I am not authenticated$/ do
  visit('/users/sign_out') # ensure that at least
end

Given /^I am a logged in (.*)$/ do |user|
  email = 'testing@man.net'
  password = 'secretpass'
  if user == 'admin'
    User.new(:email => email, :password => password, :password_confirmation => password, :admin => true).save!
  else
    User.new(:email => email, :password => password, :password_confirmation => password).save!
  end
  
  visit '/users/sign_in'
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  click_button "Log in"

end