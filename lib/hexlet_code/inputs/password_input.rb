# lib/hexlet_code/inputs/password_input.rb
# frozen_string_literal: true

module HexletCode
  module Inputs
    # Рендерит поле для ввода пароля (<input type="password">).
    class PasswordInput < BaseInput
      def initialize(name:, value:, options: {})
        super
      end

      def render
        default_options = { type: 'password' }
        attrs = { name: @name.to_s, value: @value }
                .merge(default_options)
                .merge(@options)

        attr_string = build_attributes(attrs)
        "<input #{attr_string}>"
      end

      private

      def build_attributes(attrs)
        attrs.map do |key, value|
          value ? "#{key}=\"#{value}\"" : key.to_s
        end.join(' ')
      end
    end
  end
end
