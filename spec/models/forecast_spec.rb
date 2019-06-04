require 'rails_helper'

describe Forecast, type: :model do
  describe 'Class methods' do
    describe '::find_or_create_by_location' do
      it 'creates a forecast if the location does not exist' do
        expect{Forecast.find_or_create_by_location('Denver,CO')}.to change{Forecast.count}.from(0).to(1)
      end
    end

    describe '::create_new_forecast' do
      it 'creates a new forecast for a city_state' do
        expect{Forecast.create_new_forecast('Denver,CO')}.to change{Forecast.count}.from(0).to(1)
      end
    end
  end
end
