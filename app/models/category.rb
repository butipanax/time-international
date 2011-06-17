class Category < ActiveRecord::Base
  validates_presence_of :name
  scope :mount, where('is_show=1')
  scope :get_parent_category, where(:parent_id => nil)
end
