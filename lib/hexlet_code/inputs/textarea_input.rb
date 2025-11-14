# lib/hexlet_code/inputs/textarea_input.rb
# frozen_string_literal: true

module HexletCode
  module Inputs
    # Рендерит многострочное поле ввода (<textarea>).
    class TextareaInput < BaseInput
      def initialize(name:, value:, options: {})
        super
      end

      def render
        default_options = { cols: 20, rows: 40 }

        attrs = { name: @name.to_s }
                .merge(default_options)
                .merge(@options)

        HexletCode::Tag.build('textarea', attrs) do
          @value.to_s
        end
      end
    end
  end
end
