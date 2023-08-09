class Api::V1::FlightDetailsController < ApplicationController
  require 'csv'

  def index
    flight_details = FlightDetail.all
    render json: flight_details
  end

  def show
    flight_detail = FlightDetail.find(params[:id])
    render json: flight_detail
  end

  def create
    flight_detail = FlightDetail.new(flight_detail_params)
    if flight_detail.save
      render json: flight_detail, status: :created
    else
      render json: flight_detail.errors, status: :unprocessable_entity
    end
  end

  def update
    flight_detail = FlightDetail.find(params[:id])
    if flight_detail.update(flight_detail_params)
      render json: flight_detail, status: :ok
    else
      render json: flight_detail.errors, status: :unprocessable_entity
    end
  end

  def destroy
    flight_detail = FlightDetail.find(params[:id])
    flight_detail.destroy
    render json: { message: "Flight detail with id #{params[:id]} deleted successfully" }, status: :ok
  end

  def upload
    file = params[:file]
    if file.present?
      # Parse the CSV file and create flight details
      flight_details = []
      FlightDetail.transaction do
        CSV.foreach(file.path, headers: true) do |row|
          flight_detail = FlightDetail.create(row.to_hash)
          flight_details << flight_detail
        end
      end

      # Split the flight details into saved and failed records
      saved_records, failed_records = flight_details.partition { |fd| fd.error_messages.empty? }

      # Save the valid FlightDetail objects to saved.csv and failed FlightDetail objects to failed.csv
      CSV.open("saved.csv", 'a+') do |csv1|
        CSV.open("failed.csv", 'a+') do |csv2|
          unless csv1.count.nonzero?
            csv1 << FlightDetail.column_names
            csv2 << FlightDetail.column_names
          end
          saved_records.each do |flight_detail|
            csv1 << flight_detail.attributes.values
          end
          failed_records.each do |flight_detail|
            csv2 << flight_detail.attributes.values
          end
        end
      end

      render json: { message: "CSV file uploaded and parsed successfully." }, status: :ok
    else
      render json: { error: "Please select a file to upload." }, status: :unprocessable_entity
    end
  end


  private

  def flight_detail_params
    params.require(:flight_detail).permit(:first_name, :last_name, :pnr, :fare_class, :travel_date, :pax, :ticketing_date, :email, :mobile_phone, :booked_cabin)
  end
end
