class ScheduleTransportation < ApplicationRecord
  belongs_to :schedule
  belongs_to :transportation
end
