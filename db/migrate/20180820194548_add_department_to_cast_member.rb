class AddDepartmentToCastMember < ActiveRecord::Migration[5.1]
  def change
    add_column :crew_members, :department, :string
  end
end
