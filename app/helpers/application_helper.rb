module ApplicationHelper
  include WillPaginate::ViewHelpers
  def will_paginate_with_i18n(collection = nil, options = {})
    will_paginate collection, options.merge(:previous_label => I18n.t(:previous), :next_label => I18n.t(:next))
  end

  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display:none"
    end
    content_tag("div",attributes,&block)
  end

  def get_and_update_category_list
    category_list = Hash.new
    Category.mount.get_parent_category.each do |category|
      sub_category ||= Array.new
      sub_category += Category.mount.find_all_by_parent_id(category.id)
      category_list[category] = sub_category
    end
    category_list
  end

end
