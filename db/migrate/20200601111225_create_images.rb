class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.string :uploaded_by, null: false
      t.string :description
      t.string :extension, null: false
      t.binary :stream, null: false, limit: 10.megabyte
      t.timestamps
    end
    add_index :images, :extension
    add_index :images, :uploaded_by
  end
end
