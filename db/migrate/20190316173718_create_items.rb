class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :price
      t.string :condition
      t.string :image_name
      t.integer :seller_id
      t.integer :buyer_id

      t.timestamps
    end
  end
end
