class CreateTrades < ActiveRecord::Migration[5.1]
  def change
    create_table :trades do |t|
      t.references :pair, foreign_key: true
      t.string :trade_id
      t.string :price
      t.string :quantity
      t.string :side
      t.string :timestamp

      t.timestamps
    end
  end
end
