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
          type: 'checkbox',
          value: @value || 'true'
        }.merge(@options)

        attrs[:checked] = 'checked' if checked?

        Tag.build('input', attrs)
      end

      private

      def checked?
        [@value, @options[:value]].include?(true) ||
          [@value, @options[:value]].include?('true') ||
          [@value, @options[:value]].include?('1')
      end
    end
  end
end
