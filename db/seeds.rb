
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
