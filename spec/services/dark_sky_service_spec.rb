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
  end
end
