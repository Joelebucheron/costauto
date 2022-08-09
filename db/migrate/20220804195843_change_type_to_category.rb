class ChangeTypeToCategory < ActiveRecord::Migration[6.0]
  def change
    rename_column :trips, :type, :category
  end
end
