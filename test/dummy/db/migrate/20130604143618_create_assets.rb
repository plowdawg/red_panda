class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :name
      t.date :purchase_date
      t.decimal :purchase_price
      t.integer :lifetime

      t.timestamps
    end
  end
end
