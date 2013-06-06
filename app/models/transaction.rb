class Transaction < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  attr_accessible :amount, :comment, :kid_id
  belongs_to :kid

  def format_date
    self.created_at.strftime("%m/%d/%Y")
  end

  def total
    return number_with_precision(amount, :precision => 2)
  end

end
