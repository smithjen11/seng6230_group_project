class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.decimal :payment_total
      t.string :payment_type
      t.string :employee

      t.timestamps null: false
    end
  end
end
