# lib/hexlet_code/inputs/checkbox_input.rb
# frozen_string_literal: true

module HexletCode
  module Inputs
    # Рендерит чекбокс (<input type="checkbox">).
    class CheckboxInput < BaseInput
      def initialize(name:, value:, options: {})
        super
      end

      def render
        attrs = {
          name: @name.to_s,
          type: 'checkbox'
        }.merge(@options)

        attrs[:value] = @options[:value] if @options.key?(:value)
        attrs[:checked] = 'checked' if checked?

        Tag.build('input', attrs)
      end

      private

      def checked?
        @value == true || @value == 'true' || @value == '1'
      end
    end
  end
end
