# lib/hexlet_code/inputs/password_input.rb
# frozen_string_literal: true

require_relative 'base_input'

module HexletCode
  module Inputs
    # Рендерит парольное поле (<input type="password">).
    class PasswordInput < BaseInput
      def render
        default_options = { type: 'password' }
        attrs = { name: @name.to_s, value: @value }
                .merge(default_options)
                .merge(@options)

        attr_string = build_attributes(attrs)
        "<input #{attr_string}>".strip
      end
    end
  end
end
