
# encoding: utf-8

Role.delete_all
Role.create(:name => 'admin')
Role.create(:name => 'staff')
Role.create(:name => 'customer')

OrderStatus.delete_all
OrderStatus.create(:name => 'newly created')
OrderStatus.create(:name => 'paid')
OrderStatus.create(:name => 'delivered')
OrderStatus.create(:name => 'canceld')
OrderStatus.create(:name => 'successfully closed')

DiscountDetail.delete_all
DiscountDetail.create(:discount_rate => 1)
DiscountDetail.create(:discount_rate => 0.85)
DiscountDetail.create(:discount_rate => 0.7)

SerialNumber.delete_all
SerialNumber.create(:serial_number_name => 'used_by_invoice_number', :current_max_number=>1)

BonusUpgradeDetail.delete_all
BonusUpgradeDetail.create(:objective_name =>'bonus', :bonus_reward_score => 500,:bonus_reward_score => 1000)
BonusUpgradeDetail.create(:objective_name =>'upgrade', :upgrade_level => 2,:upgrade_count => 3)
BonusUpgradeDetail.create(:objective_name =>'upgrade', :upgrade_level => 3,:upgrade_count => 8)

ShippingFee.delete_all
ShippingFee.create(:weight=>5,:price=>260)
