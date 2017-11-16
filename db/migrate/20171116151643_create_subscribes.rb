class CreateSubscribes < ActiveRecord::Migration[5.1]
  def change
    create_table :subscribes do |t|
      t.references :user, index: true
      t.integer :subscriber_id, index: true
      t.timestamps
    end
  end
end
