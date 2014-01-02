class CreateWechats < ActiveRecord::Migration
  def change
    create_table :wechats do |t|
      t.string :to_user_name
      t.string :from_user_name
      t.string :msg_type
      t.string :event
      t.string :event_key

      t.timestamps
    end
  end
end
