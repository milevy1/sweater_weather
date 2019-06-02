require 'rails_helper'

describe GoogleMapsService, type: :service do
  before :each do
    @_service ||= GoogleMapsService.new('denver,co')
  end

  describe 'Instance methods' do
    describe '#latitude' do
      it 'returns the latitude coordinate of the address' do
        expect(@_service.latitude).to eq('39.7392358')
      end
    end

    describe '#longitude' do
      it 'returns the longitude coordinate of the address' do
        expect(@_service.longitude).to eq('-104.990251')
      end
    end

    describe '#city' do
      it 'returns the city of the address' do
        expect(@_service.city).to eq('Denver')
      end
    end

    describe '#state' do
      it 'returns the state of the address' do
        expect(@_service.state).to eq('CO')
      end
    end

    describe '#city_state' do
      it 'returns the city,state of the address' do
        expect(@_service.city_state).to eq('denver,co')
      end
    end

    describe '#country' do
      it 'returns the country of the address' do
        expect(@_service.country).to eq('United States')
      end
    end
  end
end
