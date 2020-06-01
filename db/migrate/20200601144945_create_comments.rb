class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :user, index: true, null: false
      t.references :image, index: true, null: false
      t.string :content
      t.timestamps
    end
  end
end
