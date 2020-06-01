class AddPrivateToImage < ActiveRecord::Migration[6.0]
  def change
    add_column :images, :is_private, :boolean, default: false
  end
end
