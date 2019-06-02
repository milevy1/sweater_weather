class CreateForecasts < ActiveRecord::Migration[5.2]
  def change
    create_table :forecasts do |t|
      t.string :city
      t.string :state
      t.string :city_state
      t.string :country
      t.string :lat
      t.string :long
      t.jsonb :details, null: false, default: '{}'

      t.timestamps
    end
  end
end
