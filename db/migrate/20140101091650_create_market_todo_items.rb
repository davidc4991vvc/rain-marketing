class CreateMarketTodoItems < ActiveRecord::Migration
  def change
    create_table :market_todo_items do |t|
      t.references :site, index: true
      t.integer :parent_id, index: true, default: 0
      t.integer :position
      t.string :title
      t.text :description
      t.integer :priority, default: 0
      t.integer :status, default: 0
      t.integer :assigned_to, default: 0
      t.date :started_at
      t.date :finished_at

      t.timestamps
    end
  end
end
