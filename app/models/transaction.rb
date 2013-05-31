class Transaction < ActiveRecord::Base
  attr_accessible :amount, :comment, :kid_id
  belongs_to :kid

  def format_date
    self.created_at.strftime("%m/%d/%Y")
  end

  def total
    if(amount == 0)
      return "0.00"
    end
    cents = amount.to_s[-2, 2]
    dollars = amount.to_s[0..-3]
    return dollars + "." + cents
  end
end
