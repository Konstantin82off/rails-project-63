# lib/hexlet_code/inputs/submit_input.rb
# frozen_string_literal: true

module HexletCode
  module Inputs
    # Рендерит кнопку отправки формы (<input type="submit">)
    class SubmitInput < BaseInput
      def initialize(name:, value:, options: {})
        super
      end

      def render
        options = tag_options.reject { |k| k == :name }
        options.delete(:type)

        input_attrs = {
          type: 'submit',
          value: @value.to_s
        }.merge(options)

        Tag.build('input', input_attrs)
      end
    end
  end
end
