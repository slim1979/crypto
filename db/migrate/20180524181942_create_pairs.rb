class CreatePairs < ActiveRecord::Migration[5.1]
  def change
    create_table :pairs do |t|
      t.string :symbols
      t.string :baseCurrency
      t.string :quoteCurrency
      t.string :quantityIncrement
      t.string :tickSize
      t.string :takeLiquidityRate
      t.string :provideLiquidityRate
      t.string :feeCurrency

      t.timestamps
    end
  end
end
