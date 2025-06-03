class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.string :customer_name
      t.datetime :date
      t.integer :status
      t.string  :email 
      t.references :service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
