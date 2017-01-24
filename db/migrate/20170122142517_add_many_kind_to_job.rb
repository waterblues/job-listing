class AddManyKindToJob < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :many_kind, :string


  end
end
