class CreateUserSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :user_subjects do |t|
      t.references :subject, foreign_key: true
      t.references :course, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
