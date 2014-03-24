class CreateEmployeesProjects < ActiveRecord::Migration
  def change
    create_table :employees_projects do |t|
      t.column :employee_id, :integer
      t.column :project_id, :integer
    end

    drop_table :project_employees
  end
end
