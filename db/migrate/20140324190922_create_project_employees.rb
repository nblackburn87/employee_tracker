class CreateProjectEmployees < ActiveRecord::Migration
  def change
    create_table :project_employees do |t|
      t.column :employee_id, :integer
      t.column :project_id, :integer

      t.timestamps
    end
    remove_column :employees, :project_id, :integer
  end
end
