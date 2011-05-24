class Profile < ActiveRecord::Base
  belongs_to :user
  belongs_to :discount_detail, :foreign_key => "discount_rank"
  #validates :name, :sex, :address, :postcode, :telephone, :presence => true
end
