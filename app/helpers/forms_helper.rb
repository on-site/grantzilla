# frozen_string_literal: true
module FormsHelper
  def breadcrumbs
    content_tag(:ol, class: 'breadcrumb') do
      wizard_steps.collect do |every_step|
        concat(
          content_tag(:li, class: breadcrumb_class(every_step)) do
            breadcrumb(every_step)
          end
        )
      end
    end
  end

  def breadcrumb(every_step)
    if step == every_step || !@grant.persisted?
      I18n.t(every_step)
    else
      link_to I18n.t(every_step), wizard_path(every_step)
    end
  end

  def breadcrumb_class(every_step)
    if every_step == step
      "active"
    elsif past_step?(every_step)
      "past"
    else
      "future"
    end
  end

  def upload_category_classes(category)
    @categories_uploaded = @grant.uploads.map(&:category).uniq if @categories_uploaded.nil?
    if @categories_uploaded.include? category
      "glyphicon glyphicon-ok-circle text-success"
    else
      "glyphicon glyphicon-remove-circle text-danger"
    end
  end
end
