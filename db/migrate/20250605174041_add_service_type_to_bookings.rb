class AddServiceTypeToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings ,:service_type,:string ,default: "In Person"
  end
end
