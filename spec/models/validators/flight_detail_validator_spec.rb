require 'rails_helper'

RSpec.describe FlightDetailValidator do
  let(:flight_detail) { FlightDetail.new }

  describe '#validate' do
    it 'returns true if all validations pass' do
      validator = FlightDetailValidator.new(flight_detail)
      expect(validator.validate).to eq(true)
    end

    it 'adds error message if ticketing date is after travel date' do
      flight_detail.ticketing_date = Date.today
      flight_detail.travel_date = Date.today - 1.day
      validator = FlightDetailValidator.new(flight_detail)
      validator.validate
      expect(flight_detail.error_messages).to include('Ticketing Date is after Travel Date')
    end

    it 'adds error message if mobile phone format is invalid' do
      flight_detail.mobile_phone = '123'
      validator = FlightDetailValidator.new(flight_detail)
      validator.validate
      expect(flight_detail.error_messages).to include('Invalid Phone Number')
    end

    it 'adds error message if PNR format is invalid' do
      flight_detail.pnr = '123'
      validator = FlightDetailValidator.new(flight_detail)
      validator.validate
      expect(flight_detail.error_messages).to include('Invalid PNR Number')
    end

    it 'adds error message if booked cabin is invalid' do
      flight_detail.booked_cabin = 'Invalid'
      validator = FlightDetailValidator.new(flight_detail)
      validator.validate
      expect(flight_detail.error_messages).to include('Invalid Booked Cabin')
    end

    it 'adds error message if email format is invalid' do
      flight_detail.email = 'invalid-email'
      validator = FlightDetailValidator.new(flight_detail)
      validator.validate
      expect(flight_detail.error_messages).to include('Invalid Email')
    end
  end
end
