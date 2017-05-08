class CreateProjects < ActiveRecord::Migration
  def change
    create_table(:projects) do |t|
      t.column(:name, :string)
      t.column(:division_id, :integer)
    end
  end
end
