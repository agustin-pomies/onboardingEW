class ChangeCompletedDateColumnDefaultToNil < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:tasks, :completed_date, nil)
  end
end
