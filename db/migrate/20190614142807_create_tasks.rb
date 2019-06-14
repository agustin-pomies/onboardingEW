class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :description
      t.boolean :completed
      t.date :completed_date

      t.timestamps
    end
  end
end
