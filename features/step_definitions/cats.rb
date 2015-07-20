Given(/^that there are some cats in database$/) do
  2.times do
    Cat.save_new
  end
end

Given(/^I go to root path$/) do
  visit root_path
end

Then(/^I should see some pictures$/) do
  page.has_content?('img')
end

Given(/^I go to cat index page$/) do
  visit '/cats'
end

Then(/^I should see a page title$/) do
  page.has_content?('cats index')
end