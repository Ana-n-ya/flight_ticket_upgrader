require_relative 'validators/flight_detail_validator'

class FlightDetail < ActiveRecord::Base

  DISCOUNT_CODES = {
    "A".."E" => "OFFER_20",
    "F".."K" => "OFFER_30",
    "L".."R" => "OFFER_25"
  }

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :pnr, presence: true, uniqueness: true
  validates :fare_class, presence: true
  validates :travel_date, presence: true
  validates :pax, presence: true
  validates :ticketing_date, presence: true
  validates :email, presence: true
  validates :mobile_phone, presence: true
  validates :booked_cabin, presence: true

  attribute :error_messages, :string, array: true, default: [].to_yaml
  attribute :discount_code

  before_validation :reset_error_messages
  after_validation :add_discount_code

  def reset_error_messages
    self.error_messages = []
  end

  def add_discount_code
    self.discount_code = DISCOUNT_CODES.find { |range, _| range.include?(self.fare_class) }&.last
  end

  validate do |record|
    validator = FlightDetailValidator.new(record)
    validator.validate
    self.error_messages = validator.record.error_messages
  end
end

