class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :kid_id
      t.integer :amount
      t.text :comment

      t.timestamps
    end
  end
end
