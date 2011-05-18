class Profile < ActiveRecord::Base
  belongs_to :user
  validates :name, :sex, :address, :postcode, :telephone, :presence => true
end
