# lib/hexlet_code/inputs/textarea_input.rb
# frozen_string_literal: true

require_relative 'base_input'

module HexletCode
  module Inputs
    # Рендерит многострочное поле (<textarea>).
    # По умолчанию cols=20, rows=40.
    # Содержимое модели вставляется между тегами.
    # Переопределить размеры и прочие атрибуты можно через options.
    class TextareaInput < BaseInput
      def render
        default_options = { cols: 20, rows: 40 }
        attrs = { name: @name.to_s }
                .merge(default_options)
                .merge(@options)

        attr_string = build_attributes(attrs)
        "<textarea #{attr_string}>#{@value}</textarea>".strip
      end
    end
  end
end
