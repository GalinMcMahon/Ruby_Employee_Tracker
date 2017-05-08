class CreateEmployees < ActiveRecord::Migration
  def change
    create_table(:employees) do |t|
      t.column(:name, :string)
      t.column(:division_id, :integer)
    end
  end
end
