Product.transaction do
  (1..100).each do |i|
    Product.create(:title => "Title #{i}", :intro => "Intro #{i}", :category_id => 8, :description => "Description #{i}", :price => 100+i)
  end
end
