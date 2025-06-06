class AddDurationToServices < ActiveRecord::Migration[7.1]
  def change
    add_column :services, :duration, :string, default: "3-5 hours"
  end
end
