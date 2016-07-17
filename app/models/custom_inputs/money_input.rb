# frozen_string_literal: true
module CustomInputs
  class MoneyInput < SimpleForm::Inputs::Base
    include ActionView::Helpers::NumberHelper

    def input
      input_html_classes.unshift("form-control")
      input_html_options[:value] = currency_value
      template.content_tag(:div, template.content_tag(:div, "$", class: "input-group-addon") +
                                 @builder.text_field(attribute_name, input_html_options), class: "input-group")
    end

    private

    def currency_value
      number_to_currency(@builder.object.send(attribute_name), unit: "", delimiter: "")
    end
  end
end
