class Kid < ActiveRecord::Base
  attr_accessible :balance, :name
  has_many :transactions
  validates :name, :presence => true

  def total
    total = 0
    self.transactions.each do |transaction|
      total += transaction.amount
    end
    if(total > 0)
      puts total
      cents = total.to_s[-2, 2]
      dollars = total.to_s[0..-2]
      return dollars + "." + cents
    else
      return 0
    end
  end
end
