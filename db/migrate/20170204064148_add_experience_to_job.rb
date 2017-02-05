class AddExperienceToJob < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :experience, :string
  end
end
