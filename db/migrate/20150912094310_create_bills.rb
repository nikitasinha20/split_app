class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.belongs_to :group, index: true
      t.float :amount
      t.text :details
      t.integer :paid_by 
      t.timestamps null: false
    end
  end
end
