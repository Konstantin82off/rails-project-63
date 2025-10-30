# lib/hexlet_code/inputs/text_input.rb
# frozen_string_literal: true

require_relative 'base_input'

module HexletCode
  module Inputs
    # Рендерит текстовое поле (<input type="text">).
    # Поддерживает все стандартные атрибуты input-элементов.
    class TextInput < BaseInput
      def render
        attrs = prepare_attributes
        attr_string = build_attributes(attrs)
        "<input #{attr_string}>".strip
      end

      private

      def prepare_attributes
        default_options = { type: 'text' }
        { name: @name.to_s, value: @value }
          .merge(default_options)
          .merge(@options)
      end
    end
  end
end
