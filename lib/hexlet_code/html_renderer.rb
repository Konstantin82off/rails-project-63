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
      input_html = input.render

      if field[:options][:skip_label]
        input_html
      else
        label_text = field[:options][:label] || humanize_name(field[:name])
        label_attrs = { for: field[:name].to_s }
        label_html = Tag.build('label', label_attrs) { label_text }

        "#{label_html}\n#{input_html}"
      end
    end

    def create_input(field)
      type = field[:type]
      name = field[:name]
      value = field.fetch(:value, '').to_s

      options = (field[:options] || {}).except(:as)

      klass_name = "#{type.capitalize}Input"
      klass = HexletCode::Inputs.const_get(klass_name)
      klass.new(name, value, options)
    end

    def render_submit(submit_data)
      return '' unless submit_data

      value = submit_data[:value]
      options = submit_data[:options] || {}

      button_attrs = { type: 'submit' }.merge(options)

      HexletCode::Inputs::SubmitInput.new('submit', value, button_attrs).render
    end

    def humanize_name(name)
      name.to_s.tr('_', ' ').split.map(&:capitalize).join(' ')
    end

    def normalize_form_attrs(attrs)
      defaults = { action: '#', method: 'post' }
      result = defaults.merge(attrs)

      if result.key?(:url)
        result[:action] = result[:url]
        result.delete(:url)
      end

      result
    end
  end
end
