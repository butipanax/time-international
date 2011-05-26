Product.transaction do
  (1..50).each do |i|
    Product.create(:title => "Title #{i}", :intro => "Intro #{i}", :category_id => 8, :description => "Description #{i}", :price => 100+i)
  end
  (51..100).each do |i|
    Product.create(:title => "Title #{i}", :intro => "Intro #{i}", :category_id => 9, :description => "Description #{i}", :price => 100+i)
  end
end
