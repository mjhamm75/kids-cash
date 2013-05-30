class Kid < ActiveRecord::Base
  attr_accessible :balance, :name
  has_many :transactions
  validates :name, :presence => true

  def total
    total = 0
    self.transactions.each do |transaction|
      total += transaction.amount
    end
    return total
  end
end
