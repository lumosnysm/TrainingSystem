class CreateSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :subjects do |t|
      t.string :name
      t.text :description
      t.text :detail
      t.date :start_date
      t.date :end_date
      t.boolean :status
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
