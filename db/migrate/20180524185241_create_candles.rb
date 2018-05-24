class CreateCandles < ActiveRecord::Migration[5.1]
  def change
    create_table :candles do |t|
      t.references :pair, foreign_key: true
      t.string :timestamp
      t.string :open
      t.string :close
      t.string :min
      t.string :max
      t.string :volume
      t.string :volumeQuote

      t.timestamps
    end
  end
end
