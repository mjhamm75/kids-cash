class RollbackDecimalPrecision < ActiveRecord::Migration
  def change
    change_column :transactions, :amount, :decimal
  end
end
