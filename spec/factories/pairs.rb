FactoryBot.define do
  sequence :symbols do
    ('A'..'Z').to_a.sample(6).join
  end

  factory :pair do
    symbols
    baseCurrency 'FFF'
    quoteCurrency 'GGG'
    quantityIncrement 0.4
    tickSize 0.01
    takeLiquidityRate 0.3
    provideLiquidityRate 0.5
    feeCurrency 'HHH'
  end
end
