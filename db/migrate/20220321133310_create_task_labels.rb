class CreateTaskLabels < ActiveRecord::Migration[6.0]
  def change
    create_table :task_labels do |t|
      t.references :task, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
