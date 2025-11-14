# lib/hexlet_code/inputs/password_input.rb
# frozen_string_literal: true

module HexletCode
  module Inputs
    # Рендерит поле для ввода пароля (<input type="password">).
    class PasswordInput < BaseInput
      # Сохраняем инициализатор
      def initialize(name:, value:, options: {})
        super
      end

      def render
        attrs = tag_options.merge(
          type: 'password',
          value: @value
        )

        Tag.build('input', attrs)
      end
    end
  end
end
