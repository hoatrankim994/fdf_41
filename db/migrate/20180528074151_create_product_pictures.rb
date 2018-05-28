class CreateProductPictures < ActiveRecord::Migration[5.1]
  def change
    create_table :product_pictures do |t|
      t.references :product, foreign_key: true
      t.text :image
      t.timestamps
    end
  end
end
