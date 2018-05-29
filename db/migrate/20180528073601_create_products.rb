class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.integer :quantity
      t.string :detail
      t.string :picture
      t.integer :status, default: 0
      t.references :category, foreign_key: true
      t.timestamps
    end
  end
end
