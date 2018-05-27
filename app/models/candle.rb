class Candle < ApplicationRecord
  belongs_to :pair

  validates :timestamp,
            :open,
            :close,
            :min,
            :max,
            :volume,
            :volumeQuote,
            presence: true
end
