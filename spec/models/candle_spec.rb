require 'rails_helper'

RSpec.describe Candle, type: :model do
  it { should belong_to :pair }
  it { should validate_presence_of :timestamp }
  it { should validate_presence_of :open }
  it { should validate_presence_of :close }
  it { should validate_presence_of :min }
  it { should validate_presence_of :max }
  it { should validate_presence_of :volume }
  it { should validate_presence_of :volumeQuote }
end
