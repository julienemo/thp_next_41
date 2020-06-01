class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.references :uploaded_by, index: true, foreign_key: {to_table: :users}
      t.string :description
      t.string :extension, null: false
      t.binary :stream, null: false, limit: 10.megabyte
      t.timestamps
    end
    add_index :images, :extension
  end
end
