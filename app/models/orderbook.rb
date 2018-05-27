class Orderbook < ApplicationRecord
  belongs_to :pair

  validates :ask,
            :bid,
            presence: true
end
