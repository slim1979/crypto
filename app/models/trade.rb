class Trade < ApplicationRecord
  belongs_to :pair

  validates :trade_id,
            :price,
            :quantity,
            :side,
            :timestamp,
            presence: true
  validates :trade_id, uniqueness: true

end
