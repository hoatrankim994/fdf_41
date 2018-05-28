class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.boolean :gender
      t.string :address
      t.string :phone
      t.string :avartar
      t.boolean :role, default: false
      t.timestamps
    end
  end
end
