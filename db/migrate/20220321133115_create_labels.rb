class CreateLabels < ActiveRecord::Migration[6.0]
  def change
    create_table :labels do |t|
      t.text :name
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
