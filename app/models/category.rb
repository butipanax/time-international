class Category < ActiveRecord::Base
  scope :get_parent_category, where(:parent_id => nil)
end
