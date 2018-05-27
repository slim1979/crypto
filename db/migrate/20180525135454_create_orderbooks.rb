class CreateOrderbooks < ActiveRecord::Migration[5.1]
  def change
    create_table :orderbooks do |t|
      t.references :pair, foreign_key: true
      t.string :ask
      t.string :bid
      t.string :size
      t.string :price

      t.timestamps
    end
  end
end
