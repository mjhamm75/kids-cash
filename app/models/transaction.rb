class Transaction < ActiveRecord::Base
  attr_accessible :amount, :comment, :kid_id
  belongs_to :kid

  def format_date
    self.created_at.strftime("%m/%d/%Y")
  end
end
