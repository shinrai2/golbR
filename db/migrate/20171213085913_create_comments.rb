class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :email
      t.text :content
      t.references :post, foreign_key: true

      t.timestamps
    end
    add_index :comments, [:post_id, :created_at]
  end
end
