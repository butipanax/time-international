class Category < ActiveRecord::Base
  validates_presence_of :name
  scope :get_parent_category, where(:parent_id => nil)
end
