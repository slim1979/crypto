FactoryBot.define do
  sequence :trade_id do
    (0..9).to_a.sample(7).join
  end

  sequence :side do
    %w[sell buy].sample
  end

  factory :trade do
    trade_id
    price '0.01'
    quantity '0.1'
    side
    timestamp Time.now
  end
end
