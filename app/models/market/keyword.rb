class Market::Keyword < ActiveRecord::Base
  belongs_to :site
  has_many :children, class_name: "Market::Keyword",
                          foreign_key: "parent_id",
                          dependent: :destroy
  belongs_to :parent, class_name: "Market::Keyword"
  attr_accessor :opt1, :opt2
end
