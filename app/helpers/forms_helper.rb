module FormsHelper
  def breadcrumbs
    content_tag(:ol, class: 'breadcrumb') do
      wizard_steps.collect do |every_step|
        class_str =
          if every_step == step
            "active"
          elsif past_step?(every_step)
            "past"
          else
            "future"
          end

        concat(
          content_tag(:li, class: class_str) do
            link_to I18n.t(every_step), wizard_path(every_step)
          end
        )
      end
    end
  end
end
