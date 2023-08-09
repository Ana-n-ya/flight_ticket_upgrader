class RenameColumnErrorsToFlightDetails < ActiveRecord::Migration[7.0]
  def change
    rename_column :flight_details, :errors, :error_messages
  end
end
