class AddTitleShort < ActiveRecord::Migration
  def change
    add_column :blogs, :title, :string
    add_column :blogs, :short, :string
  end
end