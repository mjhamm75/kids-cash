class Transaction < ActiveRecord::Base
  attr_accessible :amount, :comment, :kid_id
  belongs_to :kid

  def format_date
    self.created_at.strftime("%m/%d/%Y")
  end

  def total
    if(self.amount == 0)
      return "0.00"
    end
    self.amount = formatAmount(amount)
    cents = self.amount.to_s[-2, 2]
    dollars = self.amount.to_s[0..-3]
    return dollars + "." + cents
  end

  def formatAmount(amount)
    while(amount / 100 < 1)
      amount -= amount * 10
    end
    return amount
  end
end
