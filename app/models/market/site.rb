class Market::Site < ActiveRecord::Base
  belongs_to :user
  has_many :keywords, dependent: :destroy
  has_many :todo_items, dependent: :destroy
end
