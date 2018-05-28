class CreateOrderbookAsks < ActiveRecord::Migration[5.1]
  def change
    create_table :orderbook_asks do |t|
      t.references :pair, foreign_key: true
      t.string :price
      t.string :size
      
      t.timestamps
    end
  end
end
