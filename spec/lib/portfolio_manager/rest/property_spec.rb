require 'spec_helper'

describe PortfolioManager::REST::Property do
  let(:client) { test_client }
  describe '#property_list' do
    let(:id) { 680_01 }
    before do
      stub_get("/account/#{id}/property/list")
        .to_return(body: fixture('property_list.xml'))
    end
    it 'returns a list of properties' do
      client.property_list(id)['response']['links']['link'].each do |link|
        expect(link).to include '@id', '@link'
      end
    end
  end

  describe "#create_property" do
    let(:account_id) { 680_01 }

    before do
      stub_post("/account/#{account_id}/property")
        .with(
          body: File.read(fixture_path + "/create_property_request.xml"),
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>'Basic dXNlcjpwYXNz',
            'Content-Length'=>'519',
            'User-Agent'=>'Ruby PortfolioManager API Client',
            'Content-Type'=>'application/xml'
          }
        )
        .to_return(body: fixture("/create_property_response.xml"))
    end

    it "creates a property and returns an id" do
      post_data = File.read(fixture_path + "/create_property_request.xml")
      new_property = client.create_property(account_id, post_data)

      expect(new_property['response']['id']).to eq("5000036")
    end
  end

  describe "#create_property_use" do
    let(:property_id) { 422 }

    before do
      stub_post("/property/#{property_id}/propertyUse")
        .with(
          body: File.read(fixture_path + "/create_property_use_request.xml"),
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>'Basic dXNlcjpwYXNz',
            'Content-Length'=>'1246',
            'User-Agent'=>'Ruby PortfolioManager API Client',
            'Content-Type'=>'application/xml'
          }
        )
        .to_return(body: fixture("/create_property_use_response.xml"))
    end

    it "creates a property use and returns an id" do
      post_data = File.read(fixture_path + "/create_property_use_request.xml")
      new_property_use = client.create_property_use(property_id, post_data)

      expect(new_property_use['response']['id']).to eq("14")
    end
  end
end
