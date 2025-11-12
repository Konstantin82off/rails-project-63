# lib/hexlet_code/inputs/select_input.rb
# frozen_string_literal: true

module HexletCode
  module Inputs
    # Рендерит выпадающий список (<select>).
    class SelectInput < BaseInput
      def initialize(name:, value:, options: {})
        super
      end

      def render
        select_attrs = tag_options.except(:choices)
        options_html = build_options_html
        Tag.build('select', select_attrs) { "\n#{options_html}\n" }
      end

      private

      def build_options_html
        @options[:choices].to_a.map do |choice|
          if choice.is_a?(Array)
            build_option_with_value_and_label(choice)
          else
            build_option_with_single_value(choice)
          end
        end.join("\n")
      end

      def build_option_with_value_and_label(choice)
        value, label = choice
        attrs = { value: value }
        attrs[:selected] = true if value == @value
        Tag.build('option', attrs) { label }
      end

      def build_option_with_single_value(choice)
        attrs = { value: choice }
        attrs[:selected] = true if choice == @value
        Tag.build('option', attrs) { choice }
      end
    end
  end
end
