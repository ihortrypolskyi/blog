class RenameContentToBody < ActiveRecord::Migration[5.0]
  def change
    rename_column :comments, :content, :body
  end
end
