# lib/hexlet_code/html_renderer.rb
# frozen_string_literal: true

module HexletCode
  # Преобразует собранные FormBuilder данные в HTML.
  # Делегирует рендеринг конкретных типов полей соответствующим классам
  # из HexletCode::Inputs (например, TextInput, TextareaInput).
  class HtmlRenderer
    # Рендерит HTML‑форму на основе состояния FormBuilder.
    def render(builder, form_attrs = {})
      form_attrs = normalize_form_attrs(form_attrs)
      fields_html = render_fields(builder.fields)
      submit_html = render_submit(builder.submit_value)

      form_content = [fields_html, submit_html].join("\n").strip
      Tag.build('form', form_attrs) { form_content }
    end

    private

    def render_fields(fields)
      fields.map { |field| render_field(field) }.join("\n")
    end

    def render_field(field)
      input = create_input(field)
      input.render_with_label
    end

    def create_input(field)
      type = field[:type]
      klass_name = "#{type.capitalize}Input"
      klass = HexletCode::Inputs.const_get(klass_name)
      klass.new(**field.except(:type))
    end

    def render_submit(submit_data)
      return '' unless submit_data

      value = submit_data[:value]
      options = submit_data[:options] || {}

      button_attrs = { type: 'submit' }.merge(options)
      HexletCode::Inputs::SubmitInput.new(
        name: 'submit',
        value: value || '',
        options: button_attrs
      ).render
    end

    def normalize_form_attrs(attrs)
      action = attrs.fetch(:url, '#')
      defaults = { action: action, method: 'post' }
      defaults.merge(attrs).except(:url)
    end
  end
end
