class CreatePlatformApiCalls < ActiveRecord::Migration[7.0]
  def change
    create_table :platform_api_calls do |t|
      t.string :requested_url
      t.text :requested_data
      t.text :response_data
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
