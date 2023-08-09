class AddErrorsToFlightDetails < ActiveRecord::Migration[7.0]
  def change
    add_column :flight_details, :errors, :text, default: [].to_yaml, array:true
  end
end
