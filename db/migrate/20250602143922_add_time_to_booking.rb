class AddTimeToBooking < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :time, :string
  end
end
