class AddContent < ActiveRecord::Migration
  def change
    add_column :blogs, :content, :binary, :limit => 10.megabyte
  end
end