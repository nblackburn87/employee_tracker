class AddDescriptionsToContributions < ActiveRecord::Migration
  def change
    add_column :contributions, :description, :text
  end
end
