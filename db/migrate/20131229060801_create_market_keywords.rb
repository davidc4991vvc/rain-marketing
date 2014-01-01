class CreateMarketKeywords < ActiveRecord::Migration
  def change
    create_table :market_keywords do |t|
      t.references :site, index: true
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :market_keywords, [:parent_id, :name], unique: true
  end
end
