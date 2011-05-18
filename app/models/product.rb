class Product < ActiveRecord::Base
  validates :title,:intro, :category_id, :description, :price, :presence => true
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }


end
