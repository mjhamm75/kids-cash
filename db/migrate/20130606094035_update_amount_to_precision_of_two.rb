class UpdateAmountToPrecisionOfTwo < ActiveRecord::Migration
  def change
    change_column :transactions, :amount, :decimal, :precision => 2
  end
end
