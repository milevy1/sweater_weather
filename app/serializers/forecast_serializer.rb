class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :updated_at, :city, :state, :country, :details
end
