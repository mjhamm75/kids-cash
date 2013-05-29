class Transaction < ActiveRecord::Base
  attr_accessible :amount, :comment, :kid_id
end
