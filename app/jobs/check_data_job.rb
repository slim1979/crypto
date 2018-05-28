class CheckDataJob < ActiveJob::Base
  queue_as :check_data

  def perform
    Pair.check_shedule
  end
end
