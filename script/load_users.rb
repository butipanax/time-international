User.transaction do
  (1..50).each do |i|
    User.create(:email => "Title #{i}@hotmail.com", :role_id => 3)
  end
end
