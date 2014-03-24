class AddDivisionIdProject < ActiveRecord::Migration
  def change
    add_column :projects, :division_id, :integer
  end
end
