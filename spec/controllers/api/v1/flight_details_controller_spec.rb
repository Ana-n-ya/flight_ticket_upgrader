require 'rails_helper'

RSpec.describe Api::V1::FlightDetailsController, type: :controller do

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    let(:flight_detail) { create(:flight_detail) }

    it "returns a success response" do
      get :show, params: { id: flight_detail.id }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    let(:valid_attributes) { attributes_for(:flight_detail) }
    let(:invalid_attributes) { attributes_for(:flight_detail, flight_number: nil) }

    context "with valid params" do
      it "creates a new flight_detail" do
        expect {
          post :create, params: { flight_detail: valid_attributes }
        }.to change(FlightDetail, :count).by(1)
      end

      it "renders a JSON response with the new flight_detail" do
        post :create, params: { flight_detail: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(api_v1_flight_detail_url(FlightDetail.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new flight_detail" do
        post :create, params: { flight_detail: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)).to include("flight_number" => ["can't be blank"])
      end
    end
  end

  describe "PUT #update" do
    let(:flight_detail) { create(:flight_detail) }
    let(:new_attributes) { { flight_number: "AA1234" } }

    context "with valid params" do
      it "updates the requested flight_detail" do
        put :update, params: { id: flight_detail.id, flight_detail: new_attributes }
        flight_detail.reload
        expect(flight_detail.flight_number).to eq("AA1234")
      end

      it "renders a JSON response with the updated flight_detail" do
        put :update, params: { id: flight_detail.id, flight_detail: new_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
        expect(response.body).to include("AA1234")
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the flight_detail" do
        put :update, params: { id: flight_detail.id, flight_detail: { flight_number: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)).to include("flight_number" => ["can't be blank"])
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:flight_detail) { create(:flight_detail) }

    it "deletes a flight detail" do
      expect {
        delete :destroy, params: { id: flight_detail.id }
      }.to change(FlightDetail, :count).by(-1)
    end

    it "returns a success message" do
      delete :destroy, params: { id: flight_detail.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq({"message" => "Flight detail with id #{flight_detail.id} deleted successfully"})
    end
  end

  describe "POST #upload" do
    let(:file_path) { Rails.root.join('spec', 'fixtures', 'files', 'flight_details.csv') }
    let(:file) { fixture_file_upload(file_path, 'text/csv') }

    context "when CSV file is valid" do
      before do
        post :upload, params: { file: file }
      end

      it "creates FlightDetail objects from a CSV file" do
        expect(response).to have_http_status(:ok)
      end

      it "saves the valid FlightDetail objects to saved.csv" do
        saved_file_path = Rails.root.join('saved.csv')
        expect(File.exist?(saved_file_path)).to be_truthy

        saved_csv_data = CSV.read(saved_file_path, headers: true)
        expect(saved_csv_data.count).to eq(2) # number of valid records in fixture CSV
      end

      it "saves the invalid FlightDetail objects to failed.csv" do
        failed_file_path = Rails.root.join('failed.csv')
        expect(File.exist?(failed_file_path)).to be_truthy

        failed_csv_data = CSV.read(failed_file_path, headers: true)
        expect(failed_csv_data.count).to eq(1) # number of invalid records in fixture CSV
      end
    end

    context "when CSV file is invalid" do
      let(:invalid_file_path) { Rails.root.join('spec', 'fixtures', 'files', 'invalid_flight_details.csv') }
      let(:invalid_file) { fixture_file_upload(invalid_file_path, 'text/csv') }

      before do
        post :upload, params: { file: invalid_file }
      end

      it "returns unprocessable_entity response" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "does not create any FlightDetail object" do
        expect(FlightDetail.count).to eq(0)
      end

      it "does not generate any CSV files" do
        expect(File.exist?(Rails.root.join('saved.csv'))).to be_falsey
        expect(File.exist?(Rails.root.join('failed.csv'))).to be_falsey
      end
    end
  end
end
