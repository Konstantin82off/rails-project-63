# lib/hexlet_code/html_renderer.rb
# frozen_string_literal: true

require_relative 'inputs/text_input'
require_relative 'inputs/checkbox_input'
require_relative 'inputs/select_input'
require_relative 'inputs/textarea_input'
require_relative 'inputs/password_input'

module HexletCode
  # HtmlRenderer — преобразует состояние формы (FormState)
  # в HTML‑разметку. Поддерживает разные типы полей и настраиваемые атрибуты.
  class HtmlRenderer
    # Рендерит HTML‑форму на основе состояния и атрибутов.
    #
    # @param state [FormState] состояние формы (собранные поля)
    # @param form_attrs [Hash] атрибуты тега <form> (action, method, class и т.д.)
    # @return [String] готовая HTML‑разметка формы
    def render(state, form_attrs = {})
      fields_html = render_fields(state.fields)
      form_attrs = normalize_form_attrs(form_attrs)

      Tag.build('form', form_attrs) { fields_html }
    end

    private

    def render_fields(fields)
      fields.map do |field|
        case field[:role]
        when :label
          render_label(field[:name])
        when :submit
          render_submit(field[:value])
        else
          render_input(field)
        end
      end.join("\n")
    end

    def render_label(name)
      Tag.build('label', for: name.to_s) { name.to_s.capitalize }
    end

    def render_submit(value)
      Tag.build('input', type: 'submit', value: value)
    end

    def render_input(field)
      as = field[:type]
      name = field[:name]
      value = field[:value]
      options = field[:options] || {}

      klass_name = "#{as.capitalize}Input"
      klass = HexletCode::Inputs.const_get(klass_name)
      input = klass.new(name, value, options)
      input.render
    end

    def normalize_form_attrs(attrs)
      defaults = { action: '#', method: 'post' }
      defaults.merge(attrs).tap do |result|
        result[:action] ||= '#'
        result[:method] ||= 'post'
      end
    end
  end
end
