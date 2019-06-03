require 'spec_helper'
require './app/serializers/antipode_serializer.rb'

describe AntipodeSerializer, type: :serializer do
  subject {
    AntipodeSerializer.new(
      {
        search_location: "Hong Kong",
        antipode_location: "Yavi Department, Jujuy, Argentina",
        antipode_forecast_summary: "Clear",
        antipode_forecast_temperature: "51.64"
        }
    )
  }

  it 'initializes with a search and antipode data' do
    expect(subject.search_location).to eq("Hong Kong")
    expect(subject.antipode_location).to eq("Yavi Department, Jujuy, Argentina")
    expect(subject.antipode_forecast_summary).to eq("Clear")
    expect(subject.antipode_forecast_temperature).to eq("51.64")
  end

  it 'serializes data' do
    expected = {
              	"data": [{
              		"id": "1",
              		"type": "antipode",
              		"attributes": {
              			"location_name": subject.antipode_location,
              			"forecast": {
              				"summary": subject.antipode_forecast_summary,
              				"current_temperature": subject.antipode_forecast_temperature
              			},
              			"search_location": subject.search_location
              		}
              	}]
              }

    expect(subject.json).to eq(expected)
  end
end
