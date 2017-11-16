class CreateFriends < ActiveRecord::Migration[5.1]
  def change
    create_table :friends do |t|
      t.references :user, index: true, foreign_key: {on_delete: :cascade}
      t.integer :friend_id, index: true
      t.timestamps
    end
  end
end
