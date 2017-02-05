class AddEducationToJob < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :education, :string
  end
end
