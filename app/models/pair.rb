class Pair < ApplicationRecord
  has_many :trades, dependent: :destroy
  has_many :candles, dependent: :destroy
  has_many :tickers, dependent: :destroy

  validates :symbols,
            :baseCurrency,
            :quoteCurrency,
            :quantityIncrement,
            :tickSize,
            :takeLiquidityRate,
            :provideLiquidityRate,
            :feeCurrency,
            presence: true
end
