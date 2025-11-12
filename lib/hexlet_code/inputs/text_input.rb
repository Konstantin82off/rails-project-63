# lib/hexlet_code/inputs/text_input.rb
# frozen_string_literal: true

module HexletCode
  module Inputs
    # Рендерит текстовое поле формы (<input type="text">).
    class TextInput < BaseInput
      def initialize(name:, value:, options: {})
        super
      end

      def render
        options = tag_options.merge(value: @value, type: 'text')
        Tag.build('input', options)
      end
    end
  end
end
