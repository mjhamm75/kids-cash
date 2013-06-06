class Kid < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  attr_accessible :balance, :name
  has_many :transactions
  validates :name, :presence => true

  def total
    total = 0
    self.transactions.each do |transaction|
      total += transaction.amount
    end
    if(total == 0)
      return "0.00"
    end

    return number_with_precision(total, :precision => 2)
  end
end
