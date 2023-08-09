class CreateFlightDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :flight_details do |t|
      t.string :first_name
      t.string :last_name
      t.string :pnr
      t.string :fare_class
      t.date :travel_date
      t.integer :pax
      t.date :ticketing_date
      t.string :email
      t.string :mobile_phone
      t.string :booked_cabin
      t.string :discount_code

      t.timestamps
    end
  end
end
