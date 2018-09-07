class CreateUserTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :user_tasks do |t|
      t.references :task, foreign_key: true
      t.references :user_subject, foreign_key: true
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
