# lib/hexlet_code/inputs/select_input.rb
# frozen_string_literal: true

require_relative 'base_input'

module HexletCode
  module Inputs
    # Рендерит выпадающий список (<select>).
    # Поддерживает:
    # - список вариантов через :choices
    # - предустановленное значение через :selected или @value
    # - произвольные атрибуты для тега <select>
    class SelectInput < BaseInput
      def render
        attrs = prepare_attributes
        options_html = render_options
        attr_string = build_attributes(attrs)
        "<select #{attr_string}>\n#{options_html}\n</select>".strip
      end

      private

      def prepare_attributes
        attrs = { name: @name.to_s }.merge(@options)
        attrs.delete(:choices)
        attrs.delete(:selected)
        attrs
      end

      def render_options
        choices  = @options.fetch(:choices, [])
        selected = @options.fetch(:selected, @value)

        choices.map do |choice|
          if choice == selected
            Tag.build('option', { value: choice, selected: true }) { choice }
          else
            Tag.build('option', { value: choice }) { choice }
          end
        end.join("\n")
      end
    end
  end
end
