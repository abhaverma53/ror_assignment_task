class ChangeSellerIdToNullableInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :seller_id, true
  end
end
