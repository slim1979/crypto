class CreateTickers < ActiveRecord::Migration[5.1]
  def change
    create_table :tickers do |t|
      t.string :ask
      t.string :bid
      t.string :last
      t.string :open
      t.string :low
      t.string :high
      t.string :volume
      t.string :volumeQuote
      t.string :timestamp
      t.string :symbol

      t.timestamps
    end
  end
end
