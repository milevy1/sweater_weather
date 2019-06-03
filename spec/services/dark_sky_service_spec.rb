require 'rails_helper'

describe DarkSkyService, type: :service do
  before :each do
    @_service ||= DarkSkyService.new('39.7392358', '-104.990251')
  end

  describe 'Instance methods' do
    describe '#details' do
      it 'returns forecast details for a given location' do
        expect(@_service.details).to be_present
      end
    end

    describe '#forecast_summary' do
      it 'returns current forecast summary for the latitude longitude' do
        expect(@_service.forecast_summary).to be_present
      end
    end

    describe '#forecast_temperature' do
      it 'returns current forecast temperature for the latitude longitude' do
        expect(@_service.forecast_temperature).to be_present
      end
    end
  end
end
