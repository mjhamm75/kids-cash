require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

Given /^I have kids named (.+)$/ do |kids|
  kids.split(', ').each do |kid|
    Kid.create!(:name => kid, :balance => 0)
  end
end

When "I go to the list of kids" do
  visit kids_path
end

When(/^I add a kid$/) do
  click_button("Add Kid")
end

And /^I give the name (.+)$/ do |kid|
  fill_in('Name', :with => kid)
end

And /^I give a balance of ([0-9]+)$/ do |balance|
  fill_in('Balance', :with => balance)
end

Then /^I should see (.+)$/ do |kid|
  find('tr', text: kid)
end

When /^I click the row (.+)$/ do |row|
  find('tr', text: row).click()
end

Then /^I will see the detail for (.+)$/ do |name|
  find 'body', text: "Jason"
end

When /^I click the button (.+)$/ do |button|
  click_button(button)
end

Then /^her balance should be ([0-9]+)$/ do |balance|
  balance.to_i
end

Given /^there is a detail page for (.+)$/ do |kid|
  Kid.create!(:name => kid, :balance => 0)
end


Given /^I go to the detail page for (.+)$/ do |kid|
  @kid = Kid.find_by_name("#{kid}")
  visit kid_path(@kid.id)
end

Given /^he has a debit of \-(\d+)$/ do |amount|
  a = amount.to_i * -1
  @kid.transactions.create!(:amount => a)
end

Given /^he has a credit of (\d+)$/ do |amount|
  @kid.transactions.create!(:amount => amount.to_i)
end

Then /^he should have a debit of \-(\d+)$/ do |amount|
  visit kid_path(@kid.id)
  a = amount.to_i * -1
  find 'body', text: a.to_s
end

Then /^he should have a credit of (\d+)$/ do |amount|
  visit kid_path(@kid.id)
  find 'body', text: amount
end

Given /^I add a debit of (\d+)$/ do |amount|
  pending # express the regexp above with the code you wish you had
end

Given /^I add a debit of \-(\d+)$/ do |amount|
  pending # express the regexp above with the code you wish you had
end