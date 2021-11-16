class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.references :type, null: false, foreign_key: true
      t.float :price
      t.string :quantity
      t.string :description

      t.timestamps
    end
  end
end
