# lib/hexlet_code/inputs/checkbox_input.rb
# frozen_string_literal: true

require_relative 'base_input'

module HexletCode
  module Inputs
    # Рендерит чекбокс (<input type="checkbox">).
    # Обрабатывает атрибут checked:
    # - если условие выполнено → выводит checked (без значения)
    # - иначе атрибут не добавляется
    class CheckboxInput < BaseInput
      def render
        attrs = prepare_attributes
        attr_string = build_attributes(attrs)
        "<input #{attr_string}>".strip
      end

      private

      def prepare_attributes
        attrs = base_attributes
        add_checked_attribute(attrs)
        attrs
      end

      def base_attributes
        default_options = { type: 'checkbox', value: @value }
        { name: @name.to_s }.merge(default_options).merge(@options)
      end

      def add_checked_attribute(attrs)
        if checked?(attrs)
          attrs[:checked] = nil
        else
          attrs.delete(:checked)
        end
      end

      def checked?(attrs)
        return true if attrs[:checked] == true

        if attrs[:checked].nil?
          @value == 'm' || @value == true || @value == 'true'
        else
          @value == attrs[:checked]
        end
      end
    end
  end
end
