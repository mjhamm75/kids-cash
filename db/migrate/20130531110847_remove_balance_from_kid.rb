class RemoveBalanceFromKid < ActiveRecord::Migration
  def up
    remove_column :kids, :balance
  end

  def down
    add_column :kids, :balance, :integer
  end
end
