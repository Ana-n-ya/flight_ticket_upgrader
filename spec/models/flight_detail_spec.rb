require 'rails_helper'

RSpec.describe FlightDetail, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:pnr) }
    it { should validate_uniqueness_of(:pnr) }
    it { should validate_presence_of(:fare_class) }
    it { should validate_presence_of(:travel_date) }
    it { should validate_presence_of(:pax) }
    it { should validate_presence_of(:ticketing_date) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:mobile_phone) }
    it { should validate_presence_of(:booked_cabin) }
  end

  describe 'attributes' do
    it { should have_attribute(:error_messages).with_default_value_of([]) }
    it { should have_attribute(:discount_code) }
  end

  describe 'callbacks' do
    describe 'before_validation' do
      it 'resets error_messages' do
        flight_detail = FlightDetail.new(error_messages: ['foo'])
        flight_detail.valid?
        expect(flight_detail.error_messages).to be_empty
      end
    end

    describe 'after_validation' do
      it 'sets discount_code based on fare_class' do
        flight_detail = FlightDetail.new(fare_class: 'B')
        flight_detail.valid?
        expect(flight_detail.discount_code).to eq('OFFER_20')
      end
    end
  end

  describe 'custom validation' do
    it 'adds error messages to error_messages' do
      flight_detail = FlightDetail.new
      flight_detail.valid?
      expect(flight_detail.error_messages).to include('Invalid Email')
      expect(flight_detail.error_messages).to include('Invalid Booked Cabin')
      expect(flight_detail.error_messages).to include('Invalid PNR Number')
      expect(flight_detail.error_messages).to include('Invalid Phone Number')
      expect(flight_detail.error_messages).to include('Ticketing Date is after Travel Date')
    end
  end
end
