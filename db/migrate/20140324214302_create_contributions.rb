class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.column :employee_id, :integer
      t.column :project_id, :integer

      t.timestamps
    end
    drop_table :employees_projects
  end
end
