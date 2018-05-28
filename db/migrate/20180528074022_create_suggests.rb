class CreateSuggests < ActiveRecord::Migration[5.1]
  def change
    create_table :suggests do |t|
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true
      t.string :product_name
      t.string :product_content
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
