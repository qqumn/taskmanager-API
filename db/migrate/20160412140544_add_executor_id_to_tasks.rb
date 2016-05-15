class AddExecutorIdToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :executor_id, :integer
  end
end
