class Transaction < ActiveRecord::Base
  attr_accessible :amount, :comment, :kid_id
  belongs_to :kid

  def format_date
    self.created_at.strftime("%m/%d/%Y")
  end

  def total
    if(amount > 0)
      puts amount
      cents = amount.to_s[-2, 2]
      dollars = amount.to_s[0..-2]
      return dollars + "." + cents
    else
      return 0
    end
  end
end
