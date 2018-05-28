FactoryBot.define do

  sequence :price do
    rand(0.000_001..0.1).round(6)
  end
  sequence :size do
    rand(0.000_001..100).round(3)
  end

  factory :orderbook_ask do
    price
    size
  end
end
