class Transaction < ActiveRecord::Base
  attr_accessible :amount, :comment, :kid_id
  belongs_to :kid

  def format_date
    self.created_at.strftime("%m/%d/%Y")
  end

  def total
    cents = amount.to_s[-2, 2]
    dollars = amount.to_s[0..-3]
    return dollars + "." + cents
  end
end
