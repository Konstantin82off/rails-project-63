# lib/hexlet_code/inputs/textarea_input.rb
# frozen_string_literal: true

module HexletCode
  module Inputs
    # Рендерит многострочное поле ввода (<textarea>).
    class TextareaInput < BaseInput
      def render
        cols = @options.fetch(:cols, 20)
        rows = @options.fetch(:rows, 40)

        textarea_attrs = {
          name: @name,
          cols: cols,
          rows: rows
        }

        Tag.build('textarea', textarea_attrs) { @value }
      end
    end
  end
end
