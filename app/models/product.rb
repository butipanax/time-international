#encoding: utf-8

class Product < ActiveRecord::Base
  validates :title,:intro, :category_id, :description, :price, :cost, :presence => true
  validates_length_of :intro, :maximum => 129
  validates_numericality_of :cost, :price
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  has_many :line_items
  before_destroy :ensure_not_referenced_by_line_item
  scope :mount, where('status=1')

  def ensure_not_referenced_by_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, '无法删除该产品，已经被其他订单所使用')
      return false
    end
  end

end
