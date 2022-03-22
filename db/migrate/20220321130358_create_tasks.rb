class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :detail
      t.date :deadline
      t.string :priority
      t.string :status

      t.timestamps
    end
  end
end
