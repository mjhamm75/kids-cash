require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
include ActionView::Helpers::NumberHelper

Given /^I have kids named (.+)$/ do |kids|
  kids.split(', ').each do |kid|
    Kid.create!(:name => kid)
  end
end

When "I go to the list of kids" do
  visit kids_path
end

Then /^I should see (.+)$/ do |kid|
  find('td', text: kid)
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

When /^I click the button (.+)$/ do |button|
  click_link(button)
end

Then /^her balance should be ([0-9]+)$/ do |balance|
  balance.to_i
end

When /^I click on the row for (.+)$/ do |kid|
  find('tr', text: kid).click()
end

Then /^I am taken to the detail page for (.+)$/ do |kid|
  find('h1', text: kid)
end

When /^I add a (?:credit|debit) to (.*) for (.*)$/ do |kid, amount|
  tr = find('tr', text: kid, exact: false)
  @balance = tr.find('.money').text
  click_button('Add Amount')
  select kid, :from => 'add-transaction-name'
  fill_in('add-transaction-amount', :with => amount)
  click_link('add-transaction-finish')
end

Then /^the balance for (.*) is (?:increased|decreased) by (.*)$/ do |kid, amount|
  tr = find('tr', text: kid, exact: false)
  updated_balance = tr.find('.money').text
  total = addStrings(@balance, amount)
  totalFloat = stringToFloat(updated_balance)
  assert_equal(total, totalFloat)
end

Given /^there is a detail page for (.+)$/ do |kid|
  @kid = Kid.create!(:name => kid)
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