class CreateMarketSites < ActiveRecord::Migration
  def change
    create_table :market_sites do |t|
      t.references :user, index: true
      t.string :name 
      t.string :domain
      t.date :online_date
      t.boolean :is_locked

      t.timestamps
    end
    add_index :market_sites, [:user_id, :name], unique: true
    add_index :market_sites, [:user_id, :domain], unique: true
  end
end
