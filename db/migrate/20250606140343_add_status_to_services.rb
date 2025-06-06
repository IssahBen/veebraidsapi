class AddStatusToServices < ActiveRecord::Migration[7.1]
  def change
    add_column :services,:status,:boolean ,default: "true"
  end
end
