class Market::TodoItem < ActiveRecord::Base
  belongs_to :site

  has_many :children, -> { order("position DESC") }, 
    class_name: "Market::TodoItem", 
    foreign_key: "parent_id", 
    dependent: :destroy
  belongs_to :parent, class_name: "Market::TodoItem"
  acts_as_list scope: :parent

end
