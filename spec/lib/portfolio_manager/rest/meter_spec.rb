require 'spec_helper'

describe PortfolioManager::REST::Meter do
  let(:client) { test_client }

  describe '#meter' do
    let(:id) { 543 }
    before do
      stub_get("/meter/#{id}")
        .to_return(body: fixture('meter.xml'))
    end
    it 'returns a meter' do
      expect(client.meter(id)['meter'])
        .to include 'id', 'type', 'name', 'unitOfMeasure', 'metered', 'firstBillDate'
    end
  end

  describe '#meter_list' do
    let(:id) { 680_01 }
    before do
      stub_get("/property/#{id}/meter/list")
        .to_return(body: fixture('meter_list.xml'))
    end
    it 'returns a list of meters' do
      client.meter_list(id)['response']['links']['link'].each do |link|
        expect(link).to include '@link'
      end
    end
  end

  describe "#create_meter" do
    let(:property_id) { 680_01 }

    before do
      stub_post("/property/#{property_id}/meter")
        .with(
          body: File.read(fixture_path + "/create_meter_request.xml"),
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>'Basic dXNlcjpwYXNz',
            'Content-Length'=>'233',
            'User-Agent'=>'Ruby PortfolioManager API Client',
            'Content-Type'=>'application/xml'
          }
        )
        .to_return(body: fixture("/create_meter_response.xml"))
    end

    it "creates a meter and returns an id" do
      post_data = File.read(fixture_path + "/create_meter_request.xml")
      new_meter = client.create_meter(property_id, post_data)

      expect(new_meter['response']['id']).to eq("432")
    end
  end

  describe "#create_meter_consumption_data" do
    let(:meter_id) { 500 }

    before do
      stub_post("/meter/#{meter_id}/consumptionData")
        .with(
          body: File.read(fixture_path + "/create_consumption_data_request.xml"),
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>'Basic dXNlcjpwYXNz',
            'Content-Length'=>'339',
            'User-Agent'=>'Ruby PortfolioManager API Client',
            'Content-Type'=>'application/xml'
          }
        )
        .to_return(body: fixture("/create_consumption_data_response.xml"))
    end

    it "creates consumption data for a meter and returns an the data with ids" do
      post_data = File.read(fixture_path + "/create_consumption_data_request.xml")
      consumption_data = client.create_meter_consumption_data(meter_id, post_data)

      expect(consumption_data['meterData']['meterConsumption'].first['usage']).to eq("639573")
      consumption_data['meterData']['meterConsumption'].each do |c|
        expect(c).to include('id')
      end
    end
  end

end
